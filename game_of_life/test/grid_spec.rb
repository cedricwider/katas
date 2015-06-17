require 'rspec'
require_relative '../src/grid.rb'
require_relative '../src/cell.rb'

describe Grid do
  
  let :grid do
    Grid.new(height: 10, width: 10)
  end
  
  it 'can be initialized with height and width' do
    # initialization is done using 'let' for simplicity.
    # what remains is the null check here to make sure
    # that it can be initialized as expected
    expect(grid).not_to be nil
  end

  it 'initializes with all cells dead' do
    expect(grid.cell_at(x: 1, y: 2).alive?).to be false
  end
  
  it 'can get a cell added' do
    cell = Cell.new x:0, y:0
    grid.add cell:cell
  end
  
  it 'can return a cell by its position' do
    cell = Cell.new x:0, y:0
    grid.add cell:cell
    
    expect(grid.cell_at(x: 0, y:0)).to eq(cell)
  end
  
  it 'knows neighbouring cells of a cell' do
    center_cell = Cell.new(x:1, y:1)
    top_cell = Cell.new(x:0, y:1)
    bottom_cell = Cell.new(x:2, y:1)
    left_cell = Cell.new(x:1, y:0)
    right_cell = Cell.new(x:1, y:2)

    grid.add(cell: center_cell)
    grid.add(cell: top_cell)
    grid.add(cell: bottom_cell)
    grid.add(cell: left_cell)
    grid.add(cell: right_cell)

    neighbours = grid.neighbours_of(cell: center_cell)
    expect(neighbours.include?(top_cell)).to be true
  end

  it 'uses Moore neighbourhood to calculate neighbouring cells' do
    neighbours = grid.neighbours_of(x: 1, y: 1)
    expect(neighbours.length).to be 8
  end

  it 'allows an array of cells to be added' do
    cells = [Cell.new(x:1, y:1), Cell.new(x:0, y:1)]
    grid.add_all(cells: cells)
  end

  it 'has an each method' do
    expect(grid.respond_to?(:each)).to be true
  end

  it 'allows iteration over its cells' do
    grid.each_cell do |cell|
      expect(cell.nil?).to be false
    end
  end

end