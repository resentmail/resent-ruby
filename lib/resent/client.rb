# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

module Resent
  class Error < StandardError
    attr_reader :status, :body

    def initialize(message, status: nil, body: nil)
      super(message)
      @status = status
      @body = body
    end
  end

  # Official Resent API client.
  #
  #   resent = Resent::Client.new(ENV.fetch("RESENT_API_KEY"))
  #   result = resent.emails.send(
  #     from: "Acme <noreply@yourdomain.com>",
  #     to: "you@example.com",
  #     subject: "Hello",
  #     html: "<strong>It works!</strong>"
  #   )
  class Client
    DEFAULT_BASE_URL = "https://resent.one/api/v1"

    attr_reader :api_key, :base_url

    def initialize(api_key = nil, base_url: DEFAULT_BASE_URL)
      key = (api_key || ENV["RESENT_API_KEY"]).to_s.strip
      raise Error, "Missing API key. Pass Resent::Client.new(key) or set RESENT_API_KEY." if key.empty?

      @api_key = key
      @base_url = base_url.to_s.sub(%r{/+\z}, "")
    end

    def emails
      Emails.new(self)
    end

    def request(method, path, body: nil)
      uri = URI("#{@base_url}/#{path.sub(%r{\A/}, "")}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"
      http.open_timeout = 15
      http.read_timeout = 30

      request = case method.to_s.upcase
                when "POST" then Net::HTTP::Post.new(uri)
                when "GET" then Net::HTTP::Get.new(uri)
                else
                  raise Error, "Unsupported HTTP method: #{method}"
                end

      request["Authorization"] = "Bearer #{api_key}"
      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"
      request["User-Agent"] = "resent-ruby/#{VERSION}"
      request.body = JSON.generate(body) if body

      response = http.request(request)
      parsed = parse_json(response.body)

      unless response.is_a?(Net::HTTPSuccess)
        message = if parsed.is_a?(Hash) && parsed["error"]
                    parsed["error"].to_s
                  else
                    "Resent API error (#{response.code})"
                  end
        raise Error.new(message, status: response.code.to_i, body: parsed)
      end

      parsed
    end

    private

    def parse_json(raw)
      return {} if raw.nil? || raw.strip.empty?

      JSON.parse(raw)
    rescue JSON::ParserError
      { "raw" => raw }
    end
  end

  class Emails
    def initialize(client)
      @client = client
    end

    # Send a transactional email.
    #
    # Required: from, to, subject, and html and/or text.
    def send(from:, to:, subject:, html: nil, text: nil, cc: nil, bcc: nil, reply_to: nil)
      to_list = Array(to).map { |v| v.to_s.strip }.reject(&:empty?)
      raise Error, "from is required" if from.to_s.strip.empty?
      raise Error, "to is required" if to_list.empty?
      raise Error, "subject is required" if subject.to_s.strip.empty?
      raise Error, "html or text body is required" if html.to_s.strip.empty? && text.to_s.strip.empty?

      payload = {
        "from" => from.to_s.strip,
        "to" => to_list,
        "subject" => subject.to_s
      }
      payload["html"] = html if html && !html.to_s.empty?
      payload["text"] = text if text && !text.to_s.empty?
      payload["cc"] = Array(cc) if cc
      payload["bcc"] = Array(bcc) if bcc
      payload["reply_to"] = reply_to if reply_to

      @client.request("POST", "email/send", body: payload)
    end
  end
end
