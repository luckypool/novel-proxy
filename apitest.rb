require 'faraday'

require 'json'
require 'yaml'
require 'time'
require "zlib"


require 'pry-byebug'

URL = 'https://api.syosetu.com/novelapi/api/'

conn = Faraday.new(url: URL) do |builder|
  builder.adapter Faraday.default_adapter
  builder.response :logger
end

# updates
filter = 't-n-u-w-bg-g-gf-gl'
query  = { lim: 2, gzip: 5, out: 'yaml', libtype: 2, of: filter }
res = conn.get '', query

io = StringIO.new(res.body)
gz = Zlib::GzipReader.new(io)
gz = Zlib::Inflate.inflate(res.body)
page = gz.read()
yaml = YAML.load(page)

# {"title"=>"白騎士と古代迷宮の冒険者",
#  "ncode"=>"N8979EU",
#  "userid"=>1358344,
#  "writer"=>"ハニワ",
#  "biggenre"=>2,
#  "genre"=>201,
#  "general_firstup"=>"2018-06-11 22:53:53",
#  "general_lastup"=>"2018-09-12 22:49:22"},

 # json = JSON.parse(page)

 binding.pry


puts 'hi'


