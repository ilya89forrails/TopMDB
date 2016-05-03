require_relative 'my_movie.rb'
require_relative 'seen_movies_list.rb'

module Recommendations
  
  def not_seen(number)
    seen_movs = SeenMoviesList.instance
    @movies.reject{|m| seen_movs.watched?(m.title)}.
      sort_by { |movie| movie.class.my_weight * ((movie.rating.to_f)-8.0) * rand }.
      reverse.first(number).collect(&:to_s)
  end



  def already_seen(number)
    seen_movs = SeenMoviesList.instance
    @movies.select{|m| seen_movs.watched?(m.title)}.
      sort_by { |movie| movie.class.my_weight * rand * (seen_movs.my_rate_for(movie.title).to_s.to_f)}.
      first(number).sort_by{|movie| seen_movs.when_seen(movie.title)}.
      collect(&:to_s)
  end

end