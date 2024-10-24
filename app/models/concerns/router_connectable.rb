module RouterConnectable
  extend ActiveSupport::Concern

  def with_router
    yield api = RouterOS::API.new(self.host, self.port) if block_given?
  rescue StandardError => e
    e.message
  ensure
    api.close unless api.nil?
  end

  def execute_router_cmd(cmd, args = [])
    with_router do |router_api|
      login_response = router_api.login(self.user, self.password)

      return login_response.error_message if login_response.error?

      cmd_response = router_api.command(cmd, args)

      return cmd_response.error_message if cmd_response.error?

      cmd_response.data.empty? ? true : cmd_response.data
    end
  end
end
