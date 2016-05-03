require 'themoviedb-api'
require_relative 'movie.rb'



Tmdb::Api.key('6defbdff2f1b492733f527e9065fc32f')

module Tmdb

  module_function

    def scrape_tmdb
       all_movies.to_json
    end


  class << self
    
    private

    def one_movie (movie_id)
      one_movie = {
        title: Tmdb::Movie.detail(movie_id).title,
        year: Tmdb::Movie.detail(movie_id).release_date.split("-").first,
        country: Tmdb::Movie.detail(movie_id).production_countries.collect(&:name).join(","),
        release_date: Tmdb::Movie.detail(movie_id).release_date,
        genre: Tmdb::Movie.detail(movie_id).genres.collect(&:name).join(","),
        length: Tmdb::Movie.detail(movie_id).runtime.to_s,
        rating: Tmdb::Movie.detail(movie_id).vote_average.to_s,      
        editor: Tmdb::Movie.director(movie_id).collect(&:name).join,
        actors: Tmdb::Movie.cast(movie_id).collect(&:name).first(3).join(",")
      }
    end


    def all_movies
      result =[]

      (1..10).to_a.each do |m|
        movies_ids = Tmdb::Movie.top_rated(page: m).results.flatten.collect(&:id)
        movies_ids.each do |id|
          result.push(one_movie(id))
        end
        
      end
      result
    end
  end
end


