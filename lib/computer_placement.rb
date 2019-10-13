

class ComputerBoard


  def initialize
    computer_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    horizontal_or_verticle = ["horizontal", "verticle"].sample
    horizontal_or_verticle_2 = ["horizontal", "verticle"].sample
  #place cruiser
    if horizontal_or_verticle.sample == "horizontal"
    random_coordinates = [["A1", "A2", "A3"]
        ["A2", "A3", "A4"]
        ["B1",]
        ["B2",]
        ["C1",]
        ["C2",]
        ["D1",]
        ["D2"]].sample
      @computer_board.place(cruiser, random_coordinates)
      else
      random_coordinates = [["A1", "A2", "A3"]
        ["A2", "A3", "A4"]
        ["B1",]
        ["B2",]
        ["C1",]
        ["C2",]
        ["D1",]
        ["D2"]].sample
      @computer_board.place(cruiser, random_coordinates)
    #place submarine
      until valid? == true
        if horizontal_or_verticle_2 == "horizontal"
        random_coordinates = [["A1", "A2"]
          ["A2", "A3", "A4"]
          ["B1",]
          ["B2",]
          ["C1",]
          ["C2",]
          ["D1",]
          ["D2"]].sample
        valid? = @computer_board.valid_placement(submarine, random_coordinates)
        @computer_board.place(submarine, random_coordinates)
        else
        random_coordinates = [["A1", "A2"]
          ["A2", "A3"]
          ["B1",]
          ["B2",]
          ["C1",]
          ["C2",]
          ["D1",]
          ["D2"]].sample
        valid? = @computer_board.valid_placement(submarine, random_coordinates)
        @computer_board.place(submarine, random_coordinates)
        end
      end
    end
end
