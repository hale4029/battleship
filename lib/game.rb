require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/computer_board'

class Game
  attr_reader :board,
              :input,
              :player_cruiser,
              :player_sub,
              :computer


  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "To start a new game, enter 'p'. To quit game, enter 'q'."
    print ">"
    @input = gets.chomp.downcase
  end

  def place_cruiser
    @player_cruiser = Ship.new("Cruiser", 3)
    puts "Enter the spaces for the cruiser (ex: A1 A2 A3)"
    print ">"
    cruiser_placement = gets.chomp.upcase.split(" ")
    if @player_board.place(@player_cruiser, cruiser_placement) == nil
      puts "Invalid coordinates. Please try again."
      place_cruiser
    else
      @player_board.place(@player_cruiser, cruiser_placement)
    end
  end

  def place_submarine
    @player_sub = Ship.new("Submarine", 2)
    puts "Enter the spaces for the submarine (ex: C1 D1)"
    print ">"
    submarine_placement = gets.chomp.upcase.split(" ")
    if @player_board.place(@player_sub, submarine_placement) == nil
      puts "Invalid coordinates. Please try again."
      place_submarine
    else
      @player_board.place(@player_sub, submarine_placement)
    end
  end

  def show_boards
    puts "Computer's Board"
    print @computer.computer_board.render(true)
    puts "=========="
    puts "Your Board"
    print @player_board.render(true)
  end

  def start_game
      main_menu
      if @input = "p"
        @computer = ComputerBoard.new
        @computer.place_cruiser
        @computer.place_submarine
        @player_board = Board.new
        show_boards
        puts "You will need to lay out your ships on the board"
        puts "The cruiser is 3 units long and the submarine is 2 units long."
        place_cruiser
        show_boards
        place_submarine
      else
        puts "Goodbye!"
      end
  end

  def take_turn
    show_boards
    puts "What coordinate would you like to fire on?"
    print ">"
    shot_coordinate = gets.chomp.upcase
    shot_coordinate_validation(shot_coordinate)

  end

  def shot_feedback
    
  end

  def shot_coordinate_validation(shot)
    if @computer.computer_board.cells.keys.include?(shot) == true && @computer.computer_board.cells[shot].fired_upon? == false
      @computer.computer_board.cells[shot].fire_upon
    else
      puts "Please input a valid coordinate."
      print ">"
      shot_coordinate = gets.chomp.upcase
      shot_coordinate_validation(shot_coordinate)
    end
  end

  def end_game?
    if @player_cruiser.health + @player_sub.health == 0 || @computer.cruiser.health + @computer.submarine.health == 0
      puts "Game Over!"
    else
      take_turn
    end
  end
end
