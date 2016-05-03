require 'rspec'
require 'date'
require_relative '../lib/TopMDB/movie.rb'
require_relative '../lib/TopMDB/my_movie.rb'
require_relative '../lib/TopMDB/movies_list.rb'
require_relative '../lib/TopMDB/my_movies_list.rb'


describe 'Movie_list' do 


 let(:movies){
       MyMoviesList.new([
         {
           link:"http://imdb.com/title/tt0468569",
           title: "The Dark Knight",
           year: "2008",
           country: "USA",
           release_date: "2008-07-18", 
           genre: "Action,Crime,Drama",
           length: "152 min",
           rating: "9.0",
           editor: "Christopher Nolan",
           actors: "Christian Bale,Heath Ledger,Aaron Eckhart"
         },
         {
           link:"http://imdb.com/title/tt0099685",
           title:"Goodfellas",
           year:"1990",
           country:"not USA",
           release_date:"1990-09-21",
           genre: "Biography,Crime,Drama",
           length: "146 min",
           rating:"8.7",   
           editor:"Martin Scorsese",
           actors:"Robert De Niro,Ray Liotta,Joe Pesci"
         },
         {
           link:"http://imdb.com/title/tt0081398",
           title:"Raging Bull",
           year:"1980",
           country: "USA",
           release_date:"1980-12-19",
           genre: "Biography,Drama,Sport",
           length:"129 min",
           rating:"8.3",
           editor:"Martin Scorsese",
           actors:"Robert De Niro,Cathy Moriarty,Joe Pesci"
         }
       ])
     }




  describe 'simple methods' do
    it 'show longest movies' do
      expect(movies.longest(2)).to eq movies.sort_by(&:length).last(2).
        collect{|m| m.title + " " + m.length.to_s}.reverse
    end


    it 'show shortest movies' do
      expect(movies.shortest(2)).to eq movies.sort_by(&:length).first(2).
        collect{|m| m.title + " " + m.length.to_s}
    end
  end


  describe :by_genre do
    context "count dramas from list" do
      subject {movies.by_genre(["Drama"]).count}
      it {is_expected.to eql(3)}
    end
  end


  describe :except_genre do 
    context "count movies from list with genre not equal 'sport'" do 
      subject {movies.except_genre(["Sport"]).count}
      it {is_expected.to eql(2)}
    end
  end


  describe :all_editors do
    context "show all unique editors from list" do
      subject {movies.all_editors}
      it {is_expected.to eql(["Christopher Nolan", "Martin Scorsese"])}
    end
  end


  describe :count_by_country do 
    context "count all USA movies" do
      subject {movies.count_by_country("USA").to_i} 
      it {is_expected.to eql(2)}
    end
  end


  describe :count_except_country do 
    context "count all non-USA movies" do 
      subject {movies.count_except_country("USA").to_i}
      it {is_expected.to eql(1)}
    end
  end


  describe :count_by_editors do
    context "count movies by every editor from list" do 
      subject {movies.count_by_editors}
      it {is_expected.to eql([["Christopher Nolan", 1], ["Martin Scorsese", 2]])}
    end
  end


  describe :count_by_actors do
    context "count movies by every actor from list" do
      subject {movies.count_by_actors} 
      it {is_expected.to eql([['Aaron Eckhart', 1], ['Cathy Moriarty', 1], ['Christian Bale', 1], ['Heath Ledger', 1],  
        ['Joe Pesci', 2],  ['Ray Liotta', 1], ['Robert De Niro', 2]])}
    end
  end


  describe :by_day do
    context "count movies by day of the month" do
      subject {movies.by_day} 
      it {is_expected.to eql(["18 => 1","19 => 1", "21 => 1"])}
    end
  end


  describe :by_month do
    context "count movies by month of the year" do 
      subject {movies.by_month}
      it {is_expected.to eql(["July => 1", "September => 1", "December => 1"])}
    end
  end


  describe :by_year do
    context "count movies by year" do 
      subject {movies.by_year}
      it {is_expected.to eql(["1980 => 1", "1990 => 1", "2008 => 1"])}
    end
  end


  describe :count_by_editor do 
    context "count movies by specific editor" do 
      subject {movies.count_by_editor("Martin Scorsese")}
      it {is_expected.to eql(2)}
    end
  end


  describe :sort_by do
    context "adds sorting algorythm and sort by it" do 
    before (:each) do 
      movies.add_sort_algo (:years_genres) {|movie| [movie.year, movie.genre]}
    end
      subject {movies.sort_by(:years_genres).map{|movie| [movie.genre, movie.year]}.flatten}
      it {is_expected.to eql(['Biography','Drama','Sport', 1980, 'Biography','Crime','Drama',1990, 'Action','Crime','Drama',2008])}
    end  

     context "trying to sort with wrong (not added) algo should give unsorted list" do
      subject {movies.sort_by(:wrong_algo).map{|movie| [movie.genre, movie.year]}.flatten} 
      it {is_expected.to eql(['Action','Crime','Drama',2008,'Biography','Crime','Drama',1990,'Biography','Drama','Sport',1980])}
    end
  end


  describe :filter do 
    context "adds filters and filter by it" do 
    before(:each) do 
      movies.add_filter(:genres){|movie, *genres| movie.has_genre?(genres)}
      movies.add_filter(:years){|movie, from, to| (from..to).include?(movie.year.to_i)}
    end
      it {expect(movies.filter(genres: "Drama", years: [1990, 2010]).collect(&:title)).to eq(["The Dark Knight", "Goodfellas"])}
      it "wrong values for legal filter" do
        expect(movies.filter(genres: "Comedy", years: [1990, 2010]).collect(&:title)).to eq([])
      end
    end

    it 'raise NoMethodError if filter is wrong' do
      expect {movies.filter(editor: "Scorsese").collect(&:title)}.to raise_error NoMethodError
    end
  end


  describe :genres_list do
    context "shows list of unique genres" do 
      subject {movies.genres_list}
      it {is_expected.to eql(["Action", "Crime", "Drama", "Biography", "Sport"])}
    end
  end
  

end