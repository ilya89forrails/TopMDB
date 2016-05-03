require_relative 'TopMDB/my_movies_list.rb'
require_relative 'TopMDB/scraper.rb'
require_relative 'TopMDB/tmdb.rb'


  filename = "../data/imdb250.json"
  IMDB = MyMoviesList.from_json(filename) 



  filename = "../data/tmdb200.json"
  TMDB = MyMoviesList.from_json(filename)


def scrape(db)
	case db.to_s.downcase
	when 'imdb'
	  data = Scraper.scrape_imdb
	  my_file = File.open("../data/imdb250.json", "w+") 
      my_file.write(data.to_s)
	when 'tmdb'
	  data = Tmdb.scrape_tmdb 
	  my_file = File.open("../data/tmdb200.json", "w+") 
	  my_file.write(data.to_s)
	else
	  puts "Wrong db name, try again"
	end
end

