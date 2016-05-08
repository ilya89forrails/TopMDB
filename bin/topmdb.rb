require_relative '../lib/top_mdb.rb'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.on('-lg', '--longest', 'Longest films') do
    puts TopMDB::IMDB.longest(ARGV[0].to_i)
  end

  opts.on('-sh', '--shortest', 'Shortest films') do
    puts TopMDB::IMDB.shortest(ARGV[0].to_i)
  end

  opts.on('-ae', '--alleditors', 'All editors') do
    puts TopMDB::IMDB.all_editors
  end

  opts.on('-pr', '--print', 'Print films') do
    puts TopMDB::IMDB.print
  end

  opts.on('-sb', '--sortby', 'Sort by') do
    puts TopMDB::IMDB.sort_by(ARGV[0].to_s)
  end
end.parse!
