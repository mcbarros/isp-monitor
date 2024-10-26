class NotificationMailer < ApplicationMailer
   default from: "isp-monitor@isp-monitor"

  def status_change
    return unless params[:destination].present?

    @changes = params[:changes]
    mail(to: params[:destination], subject: "[ISP Monitor] Status change report")
  end
end
