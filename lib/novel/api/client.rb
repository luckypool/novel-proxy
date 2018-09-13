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

      def parse_response(res, entity_klass)
        io   = StringIO.new(res.body)
        gz   = Zlib::GzipReader.new(io)
        body = gz.read()
        yaml = YAML.load(body)
        counts = yaml.shift # remove all counts
        yaml.map { |y| entity_klass.parse(y) }
      end

      def fetch_updates(limit: 20)
        filter = 't-n-u-w-bg-g-gf-gl'
        query  = { lim: limit, gzip: 5, out: 'yaml', libtype: 2, of: filter }
        res  = @conn.get '', query
        parse_response(res, Novel::Entity)
      end

      def fetch_by_author_id(author_id)
        filter = 't-n-u-w-bg-g-gf-gl'
        query  = { gzip: 5, out: 'yaml', libtype: 2, of: filter, userid: author_id }
        res  = @conn.get '', query
        parse_response(res, Novel::Entity)
      end

      def fetch_novel_detail(novel_id)
        query  = { gzip: 5, out: 'yaml', libtype: 2, ncode: novel_id }
        res  = @conn.get '', query
        parse_response(res, Novel::Entity)
      end
    end
  end
end
