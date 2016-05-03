require 'rspec'
require 'date'
require 'webmock/rspec'
require 'vcr'
require "open-uri"
require "nokogiri"
require "json"


require_relative '../lib/TopMDB/movie.rb'
require_relative '../lib/TopMDB/my_movie.rb'
require_relative '../lib/TopMDB/movies_list.rb'
require_relative '../lib/TopMDB/my_movies_list.rb'
require_relative '../lib/TopMDB/scraper.rb'



describe 'Scraper' do 


it "check one movie" do
   VCR.use_cassette ('one_movie') do

 expect(Scraper.send(:one_movie, "http://www.imdb.com/title/tt0111161")).to include(title: "The Shawshank Redemption")

   end
end



it "check is it really recieves 250 times" do
   VCR.use_cassette ('all_movies') do
     expect(Scraper.send(:all_movies).count).to eql(250)
   end
end




end