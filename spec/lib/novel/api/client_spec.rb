require 'spec_helper'
require 'uri'

describe Novel::API::Client do
  subject { Novel::API::Client.new }
  it { expect(subject).to be_a Novel::API::Client }

  describe "#fetch_updates" do
    before :all do
      url = "https://api.syosetu.com/novelapi/api/?gzip=5&libtype=2&lim=20&of=t-n-u-w-bg-g-gf-gl&out=yaml"
      fixture_path = project_root("spec/fixtures/response-t-n-u-w-bg-g-gf-gl.yml.gz")
      body = File.open(fixture_path, 'r') { |f| f.read }
      WebMock.stub_request(:get, url).to_return(
        body: body,
        status: 200
      )
    end

    let(:response) do
      subject.fetch_updates
    end

    it 'returns hoge' do
      expect(response).to be_a Array
    end
  end
end
