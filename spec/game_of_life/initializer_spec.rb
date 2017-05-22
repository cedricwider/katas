require 'rspec'
require '../src/initializer'

describe Initializer do

  let :input do
    <<EOF
#Life 1.05
#D Name: Gosper glider gun
#D Author: Bill Gosper
#D The first known gun and the first known finite pattern with unbounded growth.
#D www.conwaylife.com/wiki/index.php?title=Gosper_glider_gun
#N
#P -18 -4
........................*
......................*.*
............**......**............**
...........*...*....**............**
**........*.....*...**
**........*...*.**....*.*
..........*.....*.......*
...........*...*
............**
EOF
  end

  it 'parses input in string format' do
    Initializer.parse input
  end

  it 'ignores comments in input' do
    grid = Initializer.parse input
    expect(grid.height).to be 9
  end

  it 'initializes grid correctly' do
    grid = Initializer.parse input
    cell = grid.cell_at x: 24, y: 0
    expect(cell).not_to be nil
    expect(cell.alive?).to be_truthy
  end
end