require 'vcr'
require "webmock/rspec"
require 'rspec'
require 'themoviedb-api'


require_relative '../lib/TopMDB/tmdb.rb'
require_relative '../lib/TopMDB/scraper.rb'

  describe 'Tmdb' do

    subject {Tmdb}

    describe :one_movie do
      it "check one movie" do
        VCR.use_cassette ('one_tmdb_movie') do 
        some_stub_data = Tmdb::Movie.detail(157336)
       # expect(Tmdb::Movie).to receive(:detail).with(157336).and_return(some_stub_data)
        imdb_movie = Scraper.send(:one_movie, "http://www.imdb.com/title/tt0816692/")
        expect(imdb_movie[:title]).to eql(some_stub_data.title)
        end
      end
    end







    describe :all_movies do
      it "check is it really recieves 200 times" do
        VCR.use_cassette ('all_tmdb_movies') do
         expect(Tmdb.send(:all_movies).count).to eql(200)
        end
      end
    end


end

