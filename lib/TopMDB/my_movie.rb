
require_relative 'movie.rb'

class AncientMovie < Movie
  filter {(1900..1945).cover?(year)}
  print_format "%{title} - ancient movie (%{year})"
  weight 0.2
end


class ClassicMovie < Movie
  filter {(1946..1968).cover?(year)}
  print_format "%{title} - classic movie, derected by %{editor}" # (ещё %{count_by_editor} его фильмов в списке)"
  weight 0.4
end


class ModernMovie < Movie
  filter {(1969..1999).cover?(year)}
  print_format "%{title} - moden movie:  %{actors} playing in it"
  weight 0.2
end


class NewMovie < Movie
  filter {(2000..2016).cover?(year)}
  print_format "%{title} - new movie, huge grosses!"
  weight 0.2
end