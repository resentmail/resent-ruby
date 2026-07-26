# frozen_string_literal: true

require_relative "resent/version"
require_relative "resent/client"

# Convenience alias matching other SDKs:
#   resent = Resent.new(ENV["RESENT_API_KEY"])
module Resent
  def self.new(api_key = nil, base_url: Client::DEFAULT_BASE_URL)
    Client.new(api_key, base_url: base_url)
  end
end
