require 'faraday'
require 'yaml'
require 'time'

module Novel
  class API
    class Client
      URL_PREFIX = 'https://api.syosetu.com/novelapi/api/'
      attr_reader :conn

      def initialize
        @conn = Faraday.new(url: URL_PREFIX) do |builder|
          builder.adapter Faraday.default_adapter
        end
      end

      def fetch_updates(limit: 20)
        filter = 't-n-u-w-bg-g-gf-gl'
        query  = { lim: limit, gzip: 5, out: 'yaml', libtype: 2, of: filter }
        res  = @conn.get '', query
        io   = StringIO.new(res.body)
        gz   = Zlib::GzipReader.new(io)
        body = gz.read()
        yaml = YAML.load(body)
        counts = yaml.shift
        yaml.map { |y| Novel::Entity.parse(y) }
      end
    end
  end
end
