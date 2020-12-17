require 'test_helper'

class AdministrationMailerTest < ActionMailer::TestCase
  test "exception" do
    mail = AdministrationMailer.exception(StandardError.new("blither"))
    assert_equal "Exception", mail.subject
    assert_equal ["depot@example.com"], mail.from
    assert_match "blither", mail.body.encoded
  end

end
