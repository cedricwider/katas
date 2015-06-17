class Grid

  include Enumerable

  attr_reader :height, :width

  def initialize(height: height, width: width)
    @height = height
    @width = width
    @grid = Array.new(width) { Array.new(height) }

    # all cells are 'dead' upon initialization
    for y in (0...height)
      for x in (0...width)
        cell = Cell.new(x, y)
        cell.alive=false
        self.add(cell: cell)
      end
    end
  end

  def add(cell:)
    @grid[cell.x][cell.y] = cell
  end

  def add_all(cells:)
    cells.each{|cell| self.add(cell:cell)}
  end

  def cell_at(x:, y:)
    @grid[x][y]
  end

  # searches neighbours of a cell identified either
  # by its coordinates or the object itself.
  # raises ArgumentError if neither coordinates nor cell is provided
  def neighbours_of(x: nil , y: nil, cell: nil)
    raise ArgumentError.new('Please provide either coordinates or cell') if (x.nil? && y.nil? && cell.nil?)

    unless cell.nil?
      x, y = cell.x, cell.y
    end
    neighbours=[]

    # direct neighbours
    neighbours << @grid[x-1][y] if x > 0
    neighbours << @grid[x][y-1] if y > 0
    neighbours << @grid[x+1][y] if x < @width-1
    neighbours << @grid[x][y+1] if y < @height-1

    #diagonal neighbours
    neighbours << @grid[x-1][y-1] if ((x > 0) && (y > 0))
    neighbours << @grid[x+1][y+1] if ((x < @width-1) && (y < @height-1))
    neighbours << @grid[x-1][y+1] if ((x > 0) && (y < @height-1))
    neighbours << @grid[x+1][y-1] if ((x < @width-1) && (y > 0))

    neighbours.keep_if { |x| x }
  end

  def each
    for y in (0...@height)
      for x in (0...@width)
        yield self.cell_at(x: x, y: y)
      end
    end
  end
  alias_method :each_cell, :each

end