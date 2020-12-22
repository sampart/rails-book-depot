require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should handle exceptions" do
    assert_raises StandardError do
      perform_enqueued_jobs do
        get test_raise_error_url
      end
    end

    mail = ActionMailer::Base.deliveries.last
    refute_nil mail
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Application exception", mail.subject
    assert_match "test", mail.body.encoded
  end
end
