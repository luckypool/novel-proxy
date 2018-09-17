require 'spec_helper'

describe Novel::Entity::Novel do
  describe ".parse" do
    let(:valid_data) do
      {
        "title"=>"白騎士と古代迷宮の冒険者",
        "ncode"=>"N8979EU",
        "userid"=>1358344,
        "writer"=>"ハニワ",
        "biggenre"=>2,
        "genre"=>201,
        "general_firstup"=>"2018-06-11 22:53:53",
        "general_lastup"=>"2018-09-12 22:49:22"
      }
    end

    context "when gave valid data" do
      let(:valid_category) { Novel::Entity::Category.create(valid_data["biggenre"]) }
      let(:valid_sub_category) { Novel::Entity::SubCategory.create(valid_data["genre"]) }
      let(:valid_entity) do
        Novel::Entity::Novel.new(
          id: valid_data["ncode"],
          title: valid_data["title"],
          author_id: valid_data["userid"],
          author_name: valid_data["writer"],
          category: valid_category,
          sub_category: valid_sub_category,
          created_at: Time.parse(valid_data["general_firstup"]).to_i,
          updated_at: Time.parse(valid_data["general_lastup"]).to_i
        )
      end
      subject { Novel::Entity::Novel.parse(valid_data) }
      it { is_expected.to be_a Novel::Entity::Novel }
      it { is_expected.to eq valid_entity }
      it { expect(subject.category).to be_a Novel::Entity::Category }
      it { expect(subject.sub_category).to be_a Novel::Entity::SubCategory }
    end

    context "when gave invalid data" do
      it { expect{ Novel::Entity::Novel.parse(foo: 'bar') }.to raise_error(Exception) }
    end
  end
end
