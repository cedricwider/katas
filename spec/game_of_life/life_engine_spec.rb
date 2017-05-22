require 'rspec'
require_relative '../src/ib/game_of_life/src/life_engine'
require_relative '../src/grid'
require_relative '../src/cell'

describe LifeEngine do

  let :grid do
    Grid.new(width: 10, height: 10)
  end

  let :engine do
    LifeEngine.new(grid: grid)
  end

  it 'is initialized with a grid' do
    expect(engine).to_not be nil
  end

  it 'can calculate the next state' do
    expect(engine.respond_to?(:forward)).to be true
  end

  it 'lets a cell die if it has less than two direct neighbours who are alive' do
    x=y=5
    cell = Cell.new(x, y)
    grid.add(cell: cell)
    le=LifeEngine.new(grid: grid)
    le.forward
    expect(le.grid.cell_at(x:x, y:y).alive?).to be false
  end

  it 'lets a cell die if it has more than three direct neighbours who are alive' do
    center_cell = Cell.new(5,5)
    top_cell = Cell.new(5,4)
    bottom_cell = Cell.new(5,6)
    left_cell = Cell.new(4, 5)
    right_cell = Cell.new(6,5)

    grid.add_all(cells: [center_cell, top_cell, bottom_cell, left_cell, right_cell])
    le = LifeEngine.new(grid: grid)
    le.forward

    expect(le.grid.cell_at(x: 5, y: 5).alive?).to be false
  end

  it 'lets cells with two alive neighbours live on to the next generation' do
    center_cell = Cell.new(5,5)
    top_cell = Cell.new(5,4)
    bottom_cell = Cell.new(5,6)

    grid.add_all(cells: [center_cell, top_cell, bottom_cell])
    le = LifeEngine.new(grid: grid)
    le.forward

    expect(le.grid.cell_at(x: 5, y: 5).alive?).to be true
  end

  it 'says how many cells are alive' do
    engine.grid.cell_at(x: 5, y: 5).alive=true

    expect(engine.alive_count).to be 1
  end
end
