require './lib/board'
require './lib/ship'


class ComputerBoard
  attr_accessor :computer_board, :cruiser, :submarine

  def initialize(dimensions = 4)
    @dimensions = dimensions
    @computer_board = Board.new(@dimensions)
    @computer_board.create_cells
    @ships = [@cruiser = Ship.new("Cruiser", 3), @submarine = Ship.new("Submarine", 2)]
  end

  def place_ships
    x = 0
    until x == 2
      ship = @ships[x]
      #require "pry"; binding.pry
      horizontal_or_verticle = ["H", "V"].sample
      if horizontal_or_verticle == "H"
        letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ord.chr}
        numbers = (1..(1 + (@dimensions - 1))).to_a
        letters = letters.each_cons(ship.length).to_a.sample
        numbers = ([numbers.each_cons(ship.length).to_a.sample.sample] * (@dimensions - 1)).flatten
        hash = {}
        letters.each { |letter| hash[letter] = numbers }
        random_coordinates = numbers.map { |x| "#{letters.shift}#{x}"  }
          if @computer_board.valid_placement?(ship, random_coordinates) && @computer_board.ship_does_not_exist_on_cell(random_coordinates)
            @computer_board.place(ship, random_coordinates)
          end
      else
        letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ord.chr}
        numbers = (1..(1 + (@dimensions - 1))).to_a
        letters = ([letters.each_cons(ship.length).to_a.sample.sample] * (@dimensions - 1)).flatten
        numbers = numbers.each_cons(ship.length).to_a.sample
        hash = {}
        letters.each { |letter| hash[letter] = numbers }
        random_coordinates = numbers.map { |x| "#{letters.shift}#{x}"  }
          if @computer_board.valid_placement?(ship, random_coordinates) && @computer_board.ship_does_not_exist_on_cell(random_coordinates)
            @computer_board.place(ship, random_coordinates)
          end
      end
      if @computer_board.valid_placement?(ship, random_coordinates) && @computer_board.ship_does_not_exist_on_cell(random_coordinates)
        x += 1
      end
    end
  end
end
