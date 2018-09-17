module Novel
  module Entity
    class NovelDetail < ::Hashie::Dash
      property :id, required: true
      property :title, required: true
      property :author, required: true
      property :category
      property :sub_category
      property :keywords
      property :is_concluded
      property :is_short_story
      property :word_count
      property :is_stopped
      property :is_r15
      property :is_boys_love
      property :is_girls_love
      property :is_brutal
      property :is_tensei
      property :is_tenni
      property :score
      property :total_point
      property :total_favorite_count
      property :total_review_count
      property :total_reviwer_count
      property :created_at, required: true
      property :updated_at, required: true

      def self.parse(raw)
        # raw = response from narou api
        if raw.class == Array
          raw.map { |e| self.render(e) }
        elsif raw.class == Hash
          self.render(e)
        else
          fail 'parse error'
        end
      end

      def self.render(e)
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
          keywords: e["keyword"],
          is_short_story: e["novel_type"].to_i == 2,
          is_concluded: e["end"].to_i == 0,
          word_count: e["length"],
          is_stopped: e["isstop"] == 1,
          is_r15: e["isr15"] == 1,
          is_boys_love: e["isbl"] == 1,
          is_girls_love: e["isgl"] == 1,
          is_brutal: e["iszankoku"] == 1,
          is_tensei: e["istensei"] == 1,
          is_tenni: e["istenni"] == 1,
          score: e["global_point"],
          total_favorite_count: e["fav_novel_cnt"],
          total_review_count: e["review_cnt"],
          total_point: e["all_point"],
          total_reviwer_count: e["all_hyoka_cnt"],
          created_at: Time.parse(e["general_firstup"]).to_i,
          updated_at: Time.parse(e["general_lastup"]).to_i
        )
      end
    end
  end
end
