require 'csv'
require 'date'
require 'ostruct'


class Movie
 
  def initialize(movie, m_list)

    @m_list = m_list
    @link = movie[:link]
    @title = movie[:title]
    @year = movie[:year].to_i
    @country = movie[:country]
    @genre = movie[:genre].split(",")
    @length = movie[:length].to_i
    @rating = movie[:rating].to_f
    @editor = movie[:editor]
    @actors = movie[:actors]
    @release_date = 
      case movie[:release_date].length
        when 4
          nil
        when 7
          Date.strptime(movie[:release_date], "%Y-%m")
        else
          Date.strptime(movie[:release_date], "%Y-%m-%d")        
      end

    @weight = nil
    @print_format = nil
  end

  @@types_hash={}

  attr_reader :link, :title, :year, :country, :release_date, :genre, :length, :rating, :editor, :actors, :weight, :print_format


  def has_genre?(genre)
    arr = genre
    arr = [genre] if genre.class == String
     !(@genre & arr).empty?
  end

=begin
  def has_genre?(*genres)
   !(@genre & genres).empty?
  end
=end

  def to_s_default
    "#{@title} (#{@year}), #{@genre} - #{@editor}; #{@actors}" 
  end


  def self.filter (&block)
   @@types_hash[self] = block
  end


  def self.print_format (format) 
    @print_format = format
  end


  def self.get_print_format
    @print_format
  end


  def to_s 
     self.class.get_print_format % self.to_h
  end


  def to_h
    {title: @title,
     year: @year,
     editor: @editor,
     #count_by_editor: @m_list.count_by_editor(@editor),
     actors: @actors} 
  end


  def self.weight (user_weight)
    @weight = user_weight
  end


  def self.my_weight 
    @weight
  end


  def self.year
    @year
  end


  def self.new_specific (args, m_list)
    @m_list=m_list
    year = args[:year].to_i
    @@types_hash.each {|type, m|  type.instance_variable_set("@year", year)}
    specific_movie = @@types_hash.select {|name, block| block.call}.keys.first
    specific_movie.new(args, @m_list)
  end



  def method_missing (genre, *arguments, &block)
    
    raise ArgumentError if arguments.size > 0

    formatted_genre = (genre.to_s.capitalize.chomp('?'))

    if @m_list.genres_list.include?formatted_genre 
      (@genre.include?formatted_genre)
    else 
      raise super
    end
    
  end


  def inspect
    "#<#{self.class} #{self.title}>"
  end







end
