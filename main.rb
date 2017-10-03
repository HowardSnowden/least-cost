
require './path_cost.rb'

 
 if !ARGV[0]
  puts "\n\rInput file required"
  exit(0)
 end
 
 lines = File.readlines(ARGV[0])
 path = PathCost.new(lines)
 path.exec
 puts path