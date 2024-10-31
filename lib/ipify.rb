require "net/http"

class Ipify
  BASE_URL = "https://api.ipify.org".freeze

  def self.get_current_ip
    Net::HTTP.get(URI(BASE_URL))
  end
end
