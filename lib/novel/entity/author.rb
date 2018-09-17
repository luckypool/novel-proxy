module Novel
  module Entity
    class Author < ::Hashie::Dash
      property :id,   required: true
      property :name, required: true
      property :novels

      def self.parse(raw)
        # raw = response from narou api
        if raw.class == Array
          self.render(raw.first, Novel.parse(raw))
        elsif raw.class == Hash
          self.render(e, [Novel.parse(e)])
        else
          fail 'parse error'
        end
      end

      def self.render(e, novels=[])
        self.create(e["userid"], e["writer"], novels)
      end

      def self.create(id, name, novels=[])
        self.new(id: id, name: name, novels: novels)
      end
    end
  end
end
