require 'csv'
require 'date'
require 'ostruct'

class Movie
  # Class contains information about one movie 
  def initialize(movie, m_list)
    @m_list = m_list
    @link = movie[:link]
    @title = movie[:title]
    @year = movie[:year].to_i
    @country = movie[:country]
    @genre = movie[:genre].split(',')
    @length = movie[:length].to_i
    @rating = movie[:rating].to_f
    @editor = movie[:editor]
    @actors = movie[:actors]
    @release_date =
      case movie[:release_date].length
      when 4
        nil
      when 7
        Date.strptime(movie[:release_date], '%Y-%m')
      else
        Date.strptime(movie[:release_date], '%Y-%m-%d')
      end

    @weight = nil
    @print_format = nil
  end

  @@types_hash = {}

  attr_reader :link, :title, :year, :country, :release_date, :genre, :length, :rating, :editor, :actors, :weight, :print_format

  # Method checks inclusion this genre in current movie's genres list

  def has_genre?(genre)
    arr = genre
    arr = [genre] if genre.class == String
    !(@genre & arr).empty?
  end

  #   def has_genre?(*genres)
  #    !(@genre & genres).empty?
  #   end

  # Method create one-string description of movie

  def to_s_default
    "#{@title} (#{@year}), #{@genre} - #{@editor}; #{@actors}"
  end

  # Method sets user's filter

  def self.filter(&block)
    @@types_hash[self] = block
  end

  # Method sets user's print format

  def self.print_format(format)
    @print_format = format
  end

  # Method return print format

  def self.get_print_format
    @print_format
  end

  # Overrided to_s method

  def to_s
    self.class.get_print_format % to_h
  end

  def to_h
    { title: @title,
      year: @year,
      editor: @editor,
      actors: @actors }
  end

  # Method sets user's priority weight

  def self.weight(user_weight)
    @weight = user_weight
  end

  # Method return user's priority weight

  def self.my_weight
    @weight
  end

  class << self
    attr_reader :year
  end

  # Method creates new movie of specific group (antient, classic, modern, new)

  def self.new_specific(args, m_list)
    @m_list = m_list
    year = args[:year].to_i
    @@types_hash.each { |type, _m| type.instance_variable_set('@year', year) }
    specific_movie = @@types_hash.select { |_name, block| block.call }.keys.first
    specific_movie.new(args, @m_list)
  end

  # Overrided method 'method missing'

  def method_missing(genre, *arguments, &block)
    raise ArgumentError unless arguments.empty?

    formatted_genre = genre.to_s.capitalize.chomp('?')

    if @m_list.genres_list.include?formatted_genre
      (@genre.include?formatted_genre)
    else
      raise super
    end
  end

  def inspect
    "#<#{self.class} #{title}>"
  end
end
