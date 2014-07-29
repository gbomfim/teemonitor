require 'nokogiri'
require 'json'
require 'open-uri'

require_relative 'models/page'
require_relative 'models/store'
require_relative 'pageManager'

file_path = ARGV[0]

if file_path == nil
  puts "WRONG ARGS"
  exit
end

file_str = File.open(file_path, 'rb') { |f| f.read }

if file_str == nil
  puts "FILE IS WRONG"
  exit
end

config = JSON.parse(file_str)

page = Page.new(config)

manager = PageManager.new(page)

manager.loadPage

store = manager.buildStoreData

store.tees.each do |t|
      puts t.data.to_json
end
