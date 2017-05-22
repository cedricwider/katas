require 'rspec'
require_relative '../src/ib/game_of_life/src/string_visualizer'
require_relative '../src/grid'

describe StringVisualizer do

  let :cv do
    StringVisualizer.new
  end

  let :grid do
    Grid.new(height:2, width: 2)
  end

  it 'starts each line with a | character' do
    expect(cv.visualize(grid: grid)[0]).to eq '|'
  end

  it 'uses _ for dead cells' do
    expect(cv.visualize(grid: grid)[1]).to eq '_'
  end

  it 'uses o for alive cells' do
    alive_cell = Cell.new(0,0)
    grid.add(cell:alive_cell)

    expect(cv.visualize(grid: grid)[1]).to eq 'o'
  end

end
