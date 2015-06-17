class StringVisualizer

  def visualize(grid: grid)
    str = ''
    for i in (0...grid.height)
      str << '|'
      for j in (0...grid.width)
        cell = grid.cell_at(x: j, y: i)
        str << if cell.alive?
                 'o|'
               else
                 '_|'
        end
      end
      str << "\n"
    end
    str
  end
end