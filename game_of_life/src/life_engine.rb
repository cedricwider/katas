require_relative 'grid'
class LifeEngine

  attr_accessor :grid

  def initialize(grid: grid)
    @grid = grid
  end

  def forward
    next_grid = Grid.new(height: @grid.height, width: @grid.width)
    next_grid.each_cell do |cell|
      cell.alive = @grid.cell_at(x: cell.x, y: cell.y).alive?
      neighbouring_cells = @grid.neighbours_of(cell: cell)
      alive_neighbours_count = neighbouring_cells.count {|nc| nc.alive?}
      case
        # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        when (cell.alive? && alive_neighbours_count < 2) then cell.alive = false
        # Any live cell with two or three live neighbours lives on to the next generation.
        when (cell.alive? && (alive_neighbours_count == 2 || alive_neighbours_count ==3)) then cell.alive = true
        # Any live cell with more than three live neighbours dies, as if by overcrowding.
        when (cell.alive? && alive_neighbours_count == 4) then cell.alive = false
        # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        when (cell.alive? == false && alive_neighbours_count == 3) then cell.alive = true
      end
    end
    @grid = next_grid
  end

  def alive_count
    @grid.count {|cell| cell.alive?}
  end
end