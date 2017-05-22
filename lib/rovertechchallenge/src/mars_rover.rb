module MarsRover
	class Rover
		
		attr_reader :position

		DIRECTIONS = %w(N E S W)
		MOVEMENTS = {
				N: -> (pos){ Position.new(pos.x, pos.y + 1, pos.direction) },
				S: -> (pos){ Position.new(pos.x, pos.y - 1, pos.direction) },
				E: -> (pos){ Position.new(pos.x + 1, pos.y, pos.direction) },
				W: -> (pos){ Position.new(pos.x - 1, pos.y, pos.direction) }
		}
		
		def initialize(max_x, max_y, start_position=Position.new)
			@position = start_position
			@x_range = (0..max_x)
			@y_range = (0..max_y)
		end

		def turn_right
			idx = (DIRECTIONS.index(@position.direction) + 1) % (DIRECTIONS.size() -1)
			@position = Position.new(@position.x, @position.y, DIRECTIONS[idx])
		end

		def turn_left
			idx = (DIRECTIONS.index(@position.direction) - 1)
			idx = DIRECTIONS.size()-1 if idx < 0
			@position = Position.new(@position.x, @position.y, DIRECTIONS[idx])
		end

		def move
			new_pos = MOVEMENTS[@position.direction.to_sym].(@position)
			raise IndexError.new('Can not move above/below boundaries') unless within_range? new_pos
			@position = new_pos
		end

		def run_script(script)
			script.movements.each {|mvmt| mvmt.(self)}
		end

		private

		def within_range?(pos)
			@x_range.include?(pos.x) && @y_range.include?(pos.y)
		end
	end
	
	class Position
		attr_reader :x, :y, :direction
		
		def initialize(x=0, y=0, direction='N')
			raise ArgumentError unless direction.upcase =~ /(N|S|E|W)/

			@x, @y, @direction = x, y, direction.upcase
		end
		
		def to_s
			"#{@x},#{@y},#{@direction}"
		end
	end

	class Script
		attr_reader :movements

		ACTIONS = {
				L: -> (rover){rover.turn_left},
				R: -> (rover){rover.turn_right},
				M: -> (rover){rover.move}
		}

		def initialize(actions)
			raise ArgumentError.new('Invalid input. Allowed actions are L, R or M') unless actions=~/^(L|R|M)+$/
			@movements = []
			actions.chars{|c| @movements << ACTIONS[c.to_sym]}
		end
	end

	class InputReader

		def self.parse(input)
			plays=Array.new(){Array.new(2)}
			lines=input.split(/\n/)
			grid=lines.shift.split.map{|str| str=str.to_i}
			while lines.length > 0
				x,y,direction=lines.shift.split
				start_position = Position.new(x.to_i, y.to_i, direction)
				script = Script.new(lines.shift)
				plays << [Rover.new(grid[0], grid[1], start_position), script]
			end
			plays
		end
	end
end