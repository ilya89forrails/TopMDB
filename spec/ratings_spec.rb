require 'rspec'
require 'date'
require_relative '../lib/TopMDB/movie.rb'
require_relative '../lib/TopMDB/my_movie.rb'
require_relative '../lib/TopMDB/movies_list.rb'
require_relative '../lib/TopMDB/my_movies_list.rb'
require_relative '../lib/TopMDB/ratings.rb'
require_relative '../lib/TopMDB/seen_movies_list.rb'



describe "Recommendations" do


let(:movies){MyMoviesList.from_json("spec/fixtures/movies_for_spec.json")}
    
  
    describe :not_seen do
      before(:each) do 
        SeenMoviesList.file_name("spec/fixtures/my_movies_spec.txt")
      end
      context "show 1 of not seen movies" do
        subject {movies.not_seen(247)}
        it {is_expected.to include("Rear Window - classic movie, derected by Alfred Hitchcock")}
      end
    end


    describe :already_seen do
      before(:each) do 
        SeenMoviesList.file_name("spec/fixtures/my_movies_spec.txt")
      end
      context "show 1 of already seen movies" do
        subject {movies.already_seen(3)}
        it {is_expected.to include("Modern Times - ancient movie (1936)")}
      end
    end



  end