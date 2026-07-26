<p align="center">
  <img
    alt="Send emails with Ruby — Resent"
    src="https://raw.githubusercontent.com/resentmail/resent-ruby/main/assets/banner.jpg?v=0.1.2"
    width="100%"
  />
</p>

<p align="center">
  <a href="https://rubygems.org/gems/resent"><img alt="Gem version" src="https://img.shields.io/gem/v/resent?color=b6ff5a&label=gem&style=flat-square" /></a>
  <a href="https://rubygems.org/gems/resent"><img alt="Downloads" src="https://img.shields.io/gem/dt/resent?color=111&style=flat-square" /></a>
  <a href="https://github.com/resentmail/resent-ruby/blob/main/LICENSE"><img alt="License" src="https://img.shields.io/badge/license-MIT-b6ff5a?style=flat-square" /></a>
  <a href="https://developers.resent.one/sdks/ruby"><img alt="Docs" src="https://img.shields.io/badge/docs-developers.resent.one-111?style=flat-square" /></a>
</p>

<p align="center">
  <a href="https://developers.resent.one">Documentation</a>
  ·
  <a href="https://resent.one">Website</a>
  ·
  <a href="https://rubygems.org/gems/resent">RubyGems</a>
  ·
  <a href="https://github.com/resentmail/resent-ruby">GitHub</a>
</p>

# Resent Ruby SDK

The official Ruby library for [Resent](https://resent.one) transactional email.

## Install

```bash
gem install resent
```

Or add to your Gemfile:

```ruby
gem "resent"
```

```bash
bundle install
```

## Setup

1. Verify a sending domain in the [Resent dashboard](https://resent.one/app/settings/domains/)
2. Create an API key under [Settings → API keys](https://resent.one/app/settings/api-keys/)
3. Store it as `RESENT_API_KEY`

```ruby
require "resent"

resent = Resent.new(ENV.fetch("RESENT_API_KEY"))
```

## Usage

```ruby
require "resent"

resent = Resent.new(ENV.fetch("RESENT_API_KEY"))

result = resent.emails.send(
  from: "Acme <noreply@yourdomain.com>",
  to: "you@example.com",
  subject: "Hello World",
  html: "<p>Congrats on sending your <strong>first email</strong> with Resent!</p>"
)

puts result["submission_id"]
```

## Send email using HTML

```ruby
result = resent.emails.send(
  from: "Acme <noreply@yourdomain.com>",
  to: ["you@example.com"],
  subject: "Hello World",
  html: "<strong>It works!</strong>"
)
```

## Send email using text

```ruby
result = resent.emails.send(
  from: "Acme <noreply@yourdomain.com>",
  to: "you@example.com",
  subject: "Hello World",
  text: "It works!"
)
```

## Docs

- [Getting started](https://developers.resent.one)
- [Send transactional email](https://developers.resent.one/guides/send-transactional-email)
- [Ruby SDK docs](https://developers.resent.one/sdks/ruby)
- [API overview](https://developers.resent.one)

## License

MIT © [Resent](https://resent.one)
