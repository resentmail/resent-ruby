# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/resent"

class ResentTest < Minitest::Test
  def test_missing_api_key
    ENV.delete("RESENT_API_KEY")
    assert_raises(Resent::Error) { Resent::Client.new("") }
  end

  def test_validates_body
    client = Resent::Client.new("test_key")
    err = assert_raises(Resent::Error) do
      client.emails.send(from: "a@b.com", to: "c@d.com", subject: "hi")
    end
    assert_match(/html or text/i, err.message)
  end

  def test_alias_constructor
    client = Resent.new("test_key")
    assert_kind_of Resent::Client, client
  end
end
