require 'rspec'
require_relative '../src/cell.rb'

describe Cell do
  
  it 'is initialized by two dimensional coordinates' do
    cell = Cell.new(x: 0, y: 0)
    expect(cell).not_to eq(nil)
  end
  
  it 'is initially alive' do
    cell=Cell.new(x:0, y:0)
    expect(cell.alive?).to be true
  end
  
  it 'can die' do
    cell=Cell.new(x:0, y:0)
    cell.alive=false
    expect(cell.alive?).to be false
  end

  it 'holds on to its coordinates' do
    cell = Cell.new(x:1, y:12)

    expect(cell.x).to eq 1
    expect(cell.y).to eq 12
  end
end