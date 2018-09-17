module Novel
  module Entity
    class Novel < ::Hashie::Dash
      property :id, required: true
      property :title, required: true
      property :author_id, required: true
      property :author_name, required: true
      property :category
      property :sub_category
      property :created_at, required: true
      property :updated_at, required: true

      def self.parse(raw)
        # raw = response from narou api
        if raw.class == Array
          raw.map { |e| self.render(e) }
        elsif raw.class == Hash
          self.render(raw)
        else
          fail 'parse error'
        end
      end

      def self.render(e)
        category     = Category.create(e["biggenre"])
        sub_category = SubCategory.create(e["genre"])

        self.new(
          id: e["ncode"],
          title: e["title"],
          author_id: e["userid"],
          author_name: e["writer"],
          category: category,
          sub_category: sub_category,
          created_at: Time.parse(e["general_firstup"]).to_i,
          updated_at: Time.parse(e["general_lastup"]).to_i
        )
      end
    end
  end
end
