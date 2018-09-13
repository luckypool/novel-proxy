module Novel
  class API
    require_relative 'api/client'
    attr_reader :client
    def self.initialize
      @client = Client.new
    end
  end
end
