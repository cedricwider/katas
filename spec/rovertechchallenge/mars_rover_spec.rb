require 'rspec'
require_relative '../src/ib/rovertechchallenge/src/mars_rover.rb'

describe MarsRover::Rover do

  let :rover do
    MarsRover::Rover.new 5, 5
  end

  it 'knows its position' do
    expect(rover.position.to_s).to eq '0,0,N'
  end

	it 'can be placed at a specific location' do
		pos = MarsRover::Position.new(1,2,'S')
		rvr = MarsRover::Rover.new 5,5,pos

		expect(rvr.position).to eq pos
  end

  it 'can turn right once' do
    rover.turn_right

    expect(rover.position.direction).to eq 'E'
  end

  it 'can turn left once' do
    rover.turn_left
    expect(rover.position.direction).to eq 'W'
  end

  it 'can turn right multiple times' do
    rover.turn_right
    rover.turn_right

    expect(rover.position.direction).to eq 'S'
  end

  it 'can turn left multiple times' do
    rover.turn_left
    rover.turn_left

    expect(rover.position.direction).to eq 'S'
  end

  it 'can move north' do
    rover.move

    expect(rover.position.to_s).to eq '0,1,N'
  end

  it 'moves into the right direction after turning' do
    rover.turn_right
    rover.move

    expect(rover.position.to_s).to eq '1,0,E'
  end

  it 'stays within lower bounds of the grid' do
    rover.turn_right
    rover.turn_right #facing 'south' now
    expect{rover.move}.to raise_error(IndexError)
  end

  it 'stays withing upper bounds of the grid' do
    rvr = MarsRover::Rover.new(1,1,MarsRover::Position.new(1,1,'N'))
    expect{rvr.move}.to raise_error(IndexError)
  end

end









describe MarsRover::Position do

  it 'validates input' do
    expect{MarsRover::Position.new(1,2,'q')}.to raise_error(ArgumentError)
  end

  it 'accepts lower case letters' do
    MarsRover::Position.new(1,2,'n')
  end

end







describe MarsRover::Script do

  it 'validates input' do
    expect{MarsRover::Script.new('A')}.to raise_error(ArgumentError)
    expect{MarsRover::Script.new('')}.to raise_error(ArgumentError)
    expect{MarsRover::Script.new('L R M')}.to raise_error(ArgumentError)
  end

  it 'executes a series of moments' do
    # given
    start_pos = MarsRover::Position.new(1,2,'N')
    end_pos = MarsRover::Position.new(1,3,'N')
    rover = MarsRover::Rover.new(5,5,start_pos)
    script = MarsRover::Script.new('LMLMLMLMM')

    # when
    rover.run_script script

    # then
    expect(rover.position.to_s).to eq end_pos.to_s
  end

end






describe MarsRover::InputReader do

  it 'understands a set with input for a single rover' do
    input= <<-eod
5 5
1 2 N
LMLMLMLMM
eod

    plays = MarsRover::InputReader.parse input
    expect(plays.size).to be 1
  end

  it 'understands a set with input for multiple rovers' do
    input=<<-eod
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
eod

    plays = MarsRover::InputReader.parse input
    expect(plays.size).to be 2
  end

  it 'interprets the input correctly' do
    input= <<-eod
5 5
1 2 N
LMLMLMLMM
eod

    plays = MarsRover::InputReader.parse input

    rover,script = plays[0]
    rover.run_script script

    expect(rover.position.to_s).to eq '1,3,N'
  end


end
