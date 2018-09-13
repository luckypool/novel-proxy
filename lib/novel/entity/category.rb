module Novel
  module Entity
    class Category < ::Hashie::Dash
      property :id,   required: true
      property :name

      CATEGORY = {
        1  => '恋愛',
        2  => 'ファンタジー',
        3  => '文芸',
        4  => 'SF',
        99 => 'その他',
        98 => 'ノンジャンル'
      }

      def self.create(raw_id)
        id = raw_id.to_i
        self.new(id: id, name: CATEGORY[id])
      end
    end
  end
end
