require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :board,
              :input

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "To start a new game, enter 'p'. To quit game, enter 'q'."
    print ">"
    @input = gets.chomp.downcase
  end

  def place_cruiser
    puts "Enter the spaces for the cruiser (ex: A1 A2 A3)"
    print ">"
    cruiser_placement = gets.chomp.split(" ")
    @player_board.
  end

  def start_game
      main_menu
      if @input = "p"

        @computer = ComputerBoard.new

        puts "Computer's Board"
        print @computer.computer_board.render
        puts "=========="
        puts "Your Board"
        @player_board = Board.new
        print @player_board.render(true)
        puts "You will need to lay out your ships on the board"
        puts "The cruiser is 3 units long and the submarine is 2 units long."
        place_cruiser
      else
        puts "Goodbye!"
      end
  end

  def take_turn
    @board.render
    puts "= = = = = = = ="
    @board.render(true)
    puts "What coordinate would you like to fire on?"
    print ">"
    gets.chomp.upcase
  end

end
