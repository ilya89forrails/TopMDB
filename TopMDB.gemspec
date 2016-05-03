lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)



Gem::Specification.new do |s|
  s.name        = 'TopMDB'
  s.version     = '1.0.0'
  s.date        = '2016-05-03'
  s.description = "Small gem for scraping/parsing data about most popular movies from IMDB and TMDB"
  s.authors     = ["ilya89forrails"]
  s.summary     = 'TopMDB'
  s.email       = 'ilya89forrails@gmail.com'
  s.homepage    = 'https://github.com/ilya89forrails'
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*').concat(Dir.glob('data/*')).concat(Dir.glob('../*'))
  s.test_files  = Dir.glob('spec/**/*')
  


end
