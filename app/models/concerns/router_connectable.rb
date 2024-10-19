module RouterConnectable
  extend ActiveSupport::Concern

  def with_router
    if block_given?
      api = RouterOS::API.new(self.host, self.port)
      yield api
      api.close
    end
  rescue StandardError => e
    e.message
  end

  def execute_router_cmd(cmd, args = [])
    with_router do |router_api|
      login_response = router_api.login(self.user, self.password)

      return login_response.error_message if login_response.error?

      cmd_response = router_api.command(cmd, args)

      return cmd_response.error_message if cmd_response.error?

      return cmd_response.data.empty? ? true : cmd_response.data
    end
  end
end
