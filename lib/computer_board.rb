require './lib/board'
require './lib/ship'


class ComputerBoard
  attr_accessor :computer_board, :cruiser, :submarine

  def initialize
    @computer_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def place_cruiser
    horizontal_or_verticle = ["H", "V"].sample
    if horizontal_or_verticle == "H"
      random_coordinates = [["A1", "A2", "A3"],
      ["A2", "A3", "A4"],
      ["B1", "B2", "B3"],
      ["B2", "B3", "B4"],
      ["C1", "C2", "C3"],
      ["C2", "C3", "C4"],
      ["D1", "D2", "D3"],
      ["D2", "D3", "D4"]].sample
        @computer_board.place(@cruiser, random_coordinates)
    else
      random_coordinates = [["A1", "B1", "C1"],
      ["B1", "C1", "D1"],
      ["A2", "B2", "C2"],
      ["B2", "C2", "D2"],
      ["A3", "B3", "C3"],
      ["B3", "C3", "D3"],
      ["A4", "B4", "C4"],
      ["B4", "C4", "D4"]].sample
        @computer_board.place(@cruiser, random_coordinates)
    end
  end

  def place_submarine
    x = false
    horizontal_or_verticle = ["H", "V"].sample
    until x == true
      if horizontal_or_verticle == "H"
        random_coordinates = [["A1", "A2"],
          ["A2", "A3"],
          ["A3", "A4"],
          ["B1", "B2"],
          ["B2", "B3"],
          ["B3", "B4"],
          ["C1", "C2"],
          ["C2", "C3"],
          ["C3", "C4"],
          ["D1", "D2"],
          ["D2", "D3"],
          ["D3", "D4"]].sample
        if @computer_board.valid_placement?(@submarine, random_coordinates) == true
          @computer_board.place(@submarine, random_coordinates) && x = true
        end
      else
        random_coordinates = [["A1", "B1"],
          ["B1", "C1"],
          ["C1", "D1"],
          ["A2", "B2"],
          ["B2" "C2"],
          ["C2" "D2"],
          ["A3", "B3"],
          ["B3", "C3"],
          ["C3", "D3"],
          ["A4", "B4"],
          ["B4", "C4"],
          ["C4", "D4"]].sample
        if @computer_board.valid_placement?(@submarine, random_coordinates) == true
          @computer_board.place(@submarine, random_coordinates) && x = true
        end
      end
      end
    end

 end
