require_relative 'src/cell'
require_relative 'src/grid'
require_relative 'src/string_visualizer'
require_relative 'src/life_engine'

grid = Grid.new(height: 100, width: 100)
sv = StringVisualizer.new
cells = [Cell.new(x: 5, y: 5), Cell.new(x: 4, y: 6), Cell.new(x: 5, y: 4), Cell.new(x: 6, y: 6)]
grid.add_all(cells: cells)

le = LifeEngine.new(grid: grid)

puts "Start state:\n#{sv.visualize(grid: le.grid)}"
start_time = Time.now
iterations = 0
max = grid.height * grid.width
(0..1000).each do |num|
  count = le.alive_count
  break if (count == 0 || count == max)
  le.forward
  iterations = num
end
puts "End state:\n#{sv.visualize(grid: le.grid)}\nCalculation took #{Time.now - start_time} seconds for #{iterations} iterations"