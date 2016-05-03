require 'rspec'
require 'date'
require_relative '../lib/TopMDB/movie.rb'
require_relative '../lib/TopMDB/my_movie.rb'
require_relative '../lib/TopMDB/movies_list.rb'
require_relative '../lib/TopMDB/my_movies_list.rb'
require_relative '../lib/TopMDB/ratings.rb'





describe "MyMoviesList" do


let(:movies){MyMoviesList.from_json("spec/fixtures/movies_for_spec.json")}



  describe :type_by_name do
    context "Shows movie type be entering it's title" do 
      it {expect(movies.type_by_name("Modern Times")).to eql("[AncientMovie]")}
    end
  end


  end