# frozen_string_literal: true

require_relative "lib/resent/version"

Gem::Specification.new do |spec|
  spec.name          = "resent"
  spec.version       = Resent::VERSION
  spec.authors       = ["Resent"]
  spec.email         = ["hello@resent.one"]

  spec.summary       = "Official Ruby SDK for Resent transactional email"
  spec.description   = "Send transactional email with the Resent API from Ruby. Verify a domain, set RESENT_API_KEY, then call Resent::Client#emails.send."
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
      "assets/**/*"
    ]
  end
  spec.require_paths = ["lib"]
end
