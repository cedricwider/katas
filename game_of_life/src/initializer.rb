require_relative 'grid'
require_relative 'cell'

class Initializer


  def self.parse(input)
    lines = input.split("\n").reject {|n| n =~ /^\s*#/}
    grid = Grid.new(height: lines.size, width: lines.max_by(&:size).length )
    lines.each_with_index do |line, i |
      line.chars.each_with_index do |char, j|
        grid.add(cell: Cell.new(x: j, y: i)) if char == '*'
      end
    end
    grid
  end
end