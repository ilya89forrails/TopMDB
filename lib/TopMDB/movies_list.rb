require 'csv'
require 'date'
require 'ostruct'
require 'json'

require_relative 'movie.rb'

MOVIE_KEYS = [:link, :title, :year, :country, :release_date, :genre, :length, :rating, :editor, :actors ]



class MoviesList


  def initialize(hash)
    
    @movies = hash.
     # collect{|line| OpenStruct.new(line.to_h)}.
      collect{|film| Movie.new(film, self)}
  end


  @@sort, @@filter = {}, {}
   

  def self.from_json (filename)
    new(JSON.parse(File.read(filename), symbolize_names: true))
  end


  def self.from_csv (filename)
    new(CSV.read(filename, col_sep: '|', headers: MOVIE_KEYS))
  end


  def longest (number) 
     @movies.sort_by(&:length).reverse.first(number).
      collect{|movie| movie.title + " " + movie.length.to_s} 
  end


  def shortest (number) 
    @movies.sort_by(&:length).first(number).
      collect{|movie| movie.title + " " + movie.length.to_s} 
  end


  def by_genre (genre)
    @movies.sort_by{|movie| movie.release_date if movie.release_date!=nil}.
      select{|movie| movie.has_genre?(genre)}.
      collect{|movie| movie.title + " " + movie.genre.to_s}
  end


  def except_genre (genre)
    @movies.sort_by{|movie| movie.release_date if movie.release_date!=nil}.
      delete_if{|movie| movie.has_genre?(genre)}.
      collect{|movie| movie.title + " " + movie.genre.to_s}
  end


  def all_editors
    @movies.collect(&:editor).sort.uniq
  end


  def count_by_country (country)
    @movies.count{|movie| movie.country==country}.to_s
  end


  def count_except_country (country)
    @movies.count{|movie| movie.country!=country}.to_s
  end


  def count_by_editors
    @movies.group_by(&:editor). 
      collect{|e, group| [e, group.count]}.to_h.sort 
  end


  def count_by_actors
    @movies.collect{|movie| movie.actors.chomp.split(",")}.
      flatten.group_by{|i| i}.
      collect{|actor, his_movies| [actor, his_movies.count]}.sort
  end


  def by_day
    @movies.collect{|movie| movie.release_date.day if movie.release_date!=nil}.
      group_by{|i| i}.collect{|e, group| [e, group.count]}.to_h.
      delete_if{|key, value| key.nil?}.sort.
      collect{|a,b| (a.to_s + " => " + b.to_s)}
  end


  def by_month
    @movies.collect{|movie| movie.release_date.mon if movie.release_date!=nil}.
      group_by{|i| i}.collect{|e, group| [e, group.count]}.to_h.
      delete_if{|key, value| key.nil?}.sort.
      collect{|a,b| (Date::MONTHNAMES[a].to_s + " => " + b.to_s)}
  end


  def by_year
    @movies.collect(&:year).
      group_by{|i| i}.collect{|e, group| [e, group.count]}.to_h.sort.
      collect{|a,b| (a.to_s + " => " + b.to_s)}
  end


  def count_by_editor (editor) 
    @movies.select{|m| m.editor==editor}.count
  end

  
  def print (&block)
    block = proc{|m| m.to_s} if !block_given?
    @movies.collect(&block)
  end


  def add_sort_algo (key, &value)
    @@sort[key] = value
  end


  def add_filter (key, &value)
    @@filter[key] = value
  end


  def sort_by (field1=nil, &field2)

    case
    when field1.is_a?(String)
      @movies.sort_by {|movie| movie.send(field1)}
    when field1.is_a?(Symbol)
      var = @@sort[field1]
      @movies.sort_by(&var)
    when field2
      @movies.sort_by(&field2)
    else 
      "Can't sort"
    end
  end


  def filter (args)
    args.reduce(@movies) {|memo, (arg, value)| memo.select{|m| @@filter[arg].call(m, *value)}}
  end


  def genres_list
   result ||= []
   result = @movies.collect(&:genre).flatten.uniq
  end


end




