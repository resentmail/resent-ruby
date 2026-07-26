# frozen_string_literal: true

require_relative "lib/resent/version"

Gem::Specification.new do |spec|
  spec.name          = "resent"
  spec.version       = Resent::VERSION
  spec.authors       = ["Resent"]
  spec.email         = ["hello@resent.one"]

  spec.summary       = "Official Ruby SDK for Resent transactional email"
  spec.description   = <<~DESC
    Resent is the official Ruby client for resent.one — a transactional email API built for product and platform teams.

    Install with: gem install resent  (or add gem "resent" to your Gemfile).

    Create an API key in the Resent dashboard, set RESENT_API_KEY, then send mail with a few lines of Ruby:

      require "resent"
      resent = Resent.new(ENV.fetch("RESENT_API_KEY"))
      resent.emails.send(
        from: "Acme <noreply@yourdomain.com>",
        to: "you@example.com",
        subject: "Hello World",
        html: "<strong>It works!</strong>"
      )

    Uses only Ruby stdlib (Net::HTTP + JSON) — no extra runtime gems. Supports html and/or text bodies, plus cc, bcc, and reply_to.

    Docs: https://developers.resent.one/sdks/ruby
    Dashboard: https://resent.one
    Source: https://github.com/resentmail/resent-ruby
  DESC
  spec.homepage      = "https://resent.one"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/resentmail/resent-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/resentmail/resent-ruby"
  spec.metadata["documentation_uri"] = "https://developers.resent.one/sdks/ruby"
  spec.metadata["bug_tracker_uri"] = "https://github.com/resentmail/resent-ruby/issues"

  spec.files = Dir.chdir(__dir__) do
    Dir[
      "lib/**/*",
      "LICENSE",
      "README.md",
      "assets/banner.jpg"
    ]
  end
  spec.require_paths = ["lib"]
end

