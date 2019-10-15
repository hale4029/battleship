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
        @computer_available_shots = @computer.computer_board.cells.keys
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

  def computer_shot
    @comp_shot = @computer_available_shots.sample
    @computer_available_shots.delete(@comp_shot)
    @player_board.cells[@comp_shot].fire_upon
  end

  def take_turn
    show_boards
    puts "What coordinate would you like to fire on?"
    print ">"
    shot_coordinate = gets.chomp.upcase
    shot_coordinate_validation(shot_coordinate)
    computer_shot
    # computer_open_shots = @computer.computer_board.cells.keys
    # computer_shot = computer_open_shots.sample
    # computer_open_shots.delete(computer_shot)
    shot_feedback(@computer.computer_board, shot_coordinate, "Your")
    shot_feedback(@player_board, @comp_shot, "The computer's")
  end

  def shot_feedback(board, shot_coordinate, player)
    if board.cells[shot_coordinate].render == "M"
      shot = "miss"
    elsif board.cells[shot_coordinate].render == "H"
      shot = "hit"
    elsif board.cells[shot_coordinate].render == "X"
      puts "#{player} shot on #{shot_coordinate} sunk the #{board.cells[shot_coordinate].ship.name}."
      return
    end
    puts "#{player} shot on #{shot_coordinate} was a #{shot}."
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
end
