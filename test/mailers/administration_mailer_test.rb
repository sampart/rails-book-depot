require 'test_helper'

class AdministrationMailerTest < ActionMailer::TestCase
  test "exception" do
    mail = AdministrationMailer.exception("blither")
    assert_equal "Application exception", mail.subject
    assert_equal ["depot@example.com"], mail.from
    assert_match "blither", mail.body.encoded
  end

end
