require_relative 'top_mdb/my_movies_list.rb'
require_relative 'top_mdb/scraper.rb'
require_relative 'top_mdb/tmdb.rb'
require_relative 'top_mdb/movie.rb'
require_relative 'top_mdb/my_movie.rb'
require_relative 'top_mdb/movies_list.rb'
require_relative 'top_mdb/ratings.rb'
require_relative 'top_mdb/seen_movies_list.rb'

module TopMDB
  IMDB = MyMoviesList.from_json(File.expand_path('../data/imdb250.json'))

  TMDB = MyMoviesList.from_json(File.expand_path('../data/tmdb200.json'))

  module_function

  def scrape(db)
    case db.to_s.downcase
    when 'imdb'
      data = Scraper.scrape_imdb
      my_file = File.open('../data/imdb250.json', 'w+')
      my_file.write(data.to_s)
    when 'tmdb'
      data = Tmdb.scrape_tmdb
      my_file = File.open('../data/tmdb200.json', 'w+')
      my_file.write(data.to_s)
    else
      puts 'Wrong db name, try again'
    end
  end

  def tmdbkey (api_key)
    File.write('../config/tmdb_api_key.yml', api_key)
  end
end
