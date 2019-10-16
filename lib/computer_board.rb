require './lib/board'
require './lib/ship'


class ComputerBoard
  attr_accessor :computer_board, :cruiser, :submarine

  def initialize(dimensions = 4)
    @dimensions = dimensions
    @computer_board = Board.new(@dimensions)
    @computer_board.create_cells
    @ships = [@cruiser = Ship.new("Cruiser", 3), @submarine = Ship.new("Submarine", 2)]
    @ship = nil
  end

  def horizontal_placement
    x = 0
    until x == 1
      letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ord.chr}
      numbers = (1..(1 + (@dimensions - 1))).to_a
      letters = letters.each_cons(@ship.length).to_a.sample
      numbers = ([numbers.each_cons(@ship.length).to_a.sample.sample] * (@ship.length)).flatten
      hash = {}
      letters.each { |letter| hash[letter] = numbers }
      random_coordinates = numbers.map { |x| "#{letters.shift}#{x}"  }
        if @computer_board.valid_placement?(@ship, random_coordinates) && @computer_board.ship_does_not_exist_on_cell(random_coordinates)
          x += 1
        end
    end
    random_coordinates
  end

  def vertical_placement
    x = 0
    until x == 1
      letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ord.chr}
      numbers = (1..(1 + (@dimensions - 1))).to_a
      letters = ([letters.each_cons(@ship.length).to_a.sample.sample] * (@ship.length)).flatten
      numbers = numbers.each_cons(@ship.length).to_a.sample
      hash = {}
      letters.each { |letter| hash[letter] = numbers }
      random_coordinates = numbers.map { |x| "#{letters.shift}#{x}"  }
        if @computer_board.valid_placement?(@ship, random_coordinates) && @computer_board.ship_does_not_exist_on_cell(random_coordinates)
          x += 1
        end
    end
    random_coordinates
  end

  def place_ships
    x = 0
    2.times do
      @ship = @ships[x]
      random_coordinates = [vertical_placement, horizontal_placement].sample
      @computer_board.place(@ship, random_coordinates)
      x += 1
    end
  end

end
