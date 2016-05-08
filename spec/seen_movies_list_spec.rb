require 'rspec'
require 'date'
require_relative '../lib/top_mdb/movie.rb'
require_relative '../lib/top_mdb/my_movie.rb'
require_relative '../lib/top_mdb/movies_list.rb'
require_relative '../lib/top_mdb/my_movies_list.rb'

MY_HASH = [:title, :my_rating, :seen_at].freeze

describe 'Movie_list' do
  describe :watched? do
    context 'checks writing and reading of data from my_movies.txt' do
      SeenMoviesList.file_name('my_movies.txt')
      subject { SeenMoviesList.instance }
      it { expect(subject.watched?('Goodfellas')).to eql(true) }
      it { expect(subject.my_rate_for('Goodfellas').first.to_i).to eql(10) }
      it { expect(subject.when_seen('Goodfellas').first.to_s).to eql('2016-03-28') }
    end
  end
end
