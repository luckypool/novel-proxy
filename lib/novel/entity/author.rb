module Novel
  module Entity
    class Author < ::Hashie::Dash
      property :id,   required: true
      property :name, required: true

      def self.create(id, name)
        self.new(id: id, name: name)
      end
    end
  end
end
