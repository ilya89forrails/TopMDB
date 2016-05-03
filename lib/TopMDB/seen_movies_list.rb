require 'singleton'

class SeenMoviesList
  
  include Singleton

  MY_HASH = [:title, :my_rating, :seen_at]


  @@file_name = "my_movies.txt"
  
  def self.file_name (fn)
    @@file_name = fn
  end


  def initialize
    @seen_movies = CSV.read(@@file_name, col_sep: '|').
      collect{|line| MY_HASH.zip(line).to_h}
  end

  
  def watched (title, my_rate)
    my_file = File.open(@@file_name, "a")
    my_file.puts("#{title}|#{my_rate}|#{Date.today}") 
  end


  def watched?(title)
    (@seen_movies.collect{|m| m[:title]}).include?title
  end


  def my_rate_for(title)
    @seen_movies.select{|m| m[:title]==title.to_s}.collect{|m| m[:my_rating]}
  end


  def when_seen(title)
    @seen_movies.select{|m| m[:title]==title.to_s}.collect{|m| m[:seen_at]}
  end


end