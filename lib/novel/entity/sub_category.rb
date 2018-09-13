module Novel
  class Entity
    class SubCategory < ::Hashie::Dash
      property :id,   required: true
      property :name, required: true

      CATEGORY = {
        101  => '異世界〔恋愛〕',
        102  => '現実世界〔恋愛〕',
        201  => 'ハイファンタジー〔ファンタジー〕',
        202  => 'ローファンタジー〔ファンタジー〕',
        301  => '純文学〔文芸〕',
        302  => 'ヒューマンドラマ〔文芸〕',
        303  => '歴史〔文芸〕',
        304  => '推理〔文芸〕',
        305  => 'ホラー〔文芸〕',
        306  => 'アクション〔文芸〕',
        307  => 'コメディー〔文芸〕',
        401  => 'VRゲーム〔SF〕',
        402  => '宇宙〔SF〕',
        403  => '空想科学〔SF〕',
        404  => 'パニック〔SF〕',
        9901 => '童話〔その他〕',
        9902 => '詩〔その他〕',
        9903 => 'エッセイ〔その他〕',
        9904 => 'リプレイ〔その他〕',
        9999 => 'その他〔その他〕',
        9801 => 'ノンジャンル〔ノンジャンル〕'
      }

      def self.create(raw_id)
        id = raw_id.to_i
        self.new(id: id, name: CATEGORY[id])
      end
    end
  end
end
