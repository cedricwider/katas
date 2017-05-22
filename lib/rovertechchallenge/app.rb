#!/usr/local/bin/ruby
require_relative 'src/mars_rover'

plays = MarsRover::InputReader.parse File.open(ARGV[0], 'rb').read
plays.each do |plan|
  rover, script = plan
  rover.run_script script
  puts rover.position.to_s.gsub(/,/, ' ')
end