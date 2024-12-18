ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/mock"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def login
      user = User.create(email: "admin@isp-monitor.com", password: "test")
      post login_url(email: user.email, password: user.password)
    end

    def current_user
      User.find(session[:current_user_id])
    end
  end
end
