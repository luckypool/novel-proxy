module Novel
  module Entity
    class Novel < ::Hashie::Dash
      property :id, required: true
      property :title, required: true
      property :author, required: true
      property :category
      property :sub_category
      property :created_at, required: true
      property :updated_at, required: true

      def self.parse(e)
        # e = narou_entity
        author       = Author.create(e["userid"], e["writer"])
        category     = Category.create(e["biggenre"])
        sub_category = SubCategory.create(e["genre"])

        self.new(
          id: e["ncode"],
          title: e["title"],
          author: author,
          category: category,
          sub_category: sub_category,
          created_at: Time.parse(e["general_firstup"]).to_i,
          updated_at: Time.parse(e["general_lastup"]).to_i
        )
      end
    end
  end
end
