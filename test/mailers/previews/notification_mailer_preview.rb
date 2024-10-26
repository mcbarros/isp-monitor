# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def status_change
    NotificationMailer.with(changes: [
      IpRoute.new(id: "1", comment: "Main", active: true),
      IpRoute.new(id: "2", comment: "Backup", active: false)
    ], destination: "test@test.com").status_change
  end
end
