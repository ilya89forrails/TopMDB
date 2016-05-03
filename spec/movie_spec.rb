require 'rspec'
require 'date'
require_relative '../lib/TopMDB/movie.rb'
require_relative '../lib/TopMDB/my_movie.rb'
require_relative '../lib/TopMDB/movies_list.rb'
require_relative '../lib/TopMDB/my_movies_list.rb'


describe 'Movie' do 


  let(:movie){
    Movie.new_specific({
          link: 'http://www.imdb.com/title/tt0111161',
          title: 'The Shawshank Redemption',
          year: "1994",
          country: 'USA',
          release_date: '1994-10-14',
          genre: "Drama,Crime",
          length: "142 min",
          rating: "9.3",
          editor: 'Frank Darabont',
          actors: "Tim Robbins, Morgan Freeman, Bob Gunton"}, movies)}


let(:arg){{
          link: 'http://www.imdb.com/title/tt0111161',
          title: 'The Shawshank Redemption',
          year: "1994",
          country: 'USA',
          release_date: '1994-10-14',
          genre: "Drama,Crime",
          length: "142 min",
          rating: "9.3",
          editor: 'Frank Darabont',
          actors: "Tim Robbins, Morgan Freeman, Bob Gunton"}}






let(:movies){MyMoviesList.from_json("spec/fixtures/movies_for_spec.json")}



  describe :new_specific do
    it "returns movie type depending on release year" do
      expect(Movie.new_specific(arg.merge(year: 2010), movies)).to be_a NewMovie
      expect(Movie.new_specific(arg.merge(year: 1990), movies)).to be_a ModernMovie
      expect(Movie.new_specific(arg.merge(year: 1960), movies)).to be_a ClassicMovie
      expect(Movie.new_specific(arg.merge(year: 1910), movies)).to be_a AncientMovie
    end
  end

    describe :initialize do
      it "initializes movie object" do
        expect(movie.year).to eql(1994)
        expect(movie.release_date).to eql(Date.strptime("1994-10-14", '%Y-%m-%d'))
        expect(movie.length).to eql(142)
        expect(movie.rating).to eql(9.3)
        expect(movie.actors).to eql("Tim Robbins, Morgan Freeman, Bob Gunton")
      end
    end

    describe :has_genre? do
      it "including specific genre" do 
        expect(movie.has_genre?("Drama")).to be true
        expect(movie.has_genre?("Comedy")).to be false
      end
    end



  describe :method_missing do 
    it "work if method is missing" do  
      expect(movie.crime?).to be true
      expect(movie.drama?).to be true
    end

    it 'show NoMethodError if movie genre is wrong' do
      expect {movie.borsch?}.to raise_error NoMethodError
    end

    it 'show NameError if number of arguments is wrong' do
      expect {movie.drama?(drama)}.to raise_error NameError
    end
  end
end