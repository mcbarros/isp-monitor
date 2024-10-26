require "test_helper"

class NotificationMailerTest < ActionMailer::TestCase
  test "status_change" do
    # Create the email and store it for further assertions
    email = NotificationMailer.with(changes: [
      IpRoute.new(id: "1", comment: "Main", active: true),
      IpRoute.new(id: "2", comment: "Backup", active: false)
    ], destination: "test@test.com").status_change

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal [ "isp-monitor@isp-monitor" ], email.from
    assert_equal [ "test@test.com" ], email.to
    assert_equal "[ISP Monitor] Status change report", email.subject
  end
end
