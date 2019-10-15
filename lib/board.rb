require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize
    @spaces = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @cells = {}
    @spaces.each do |space|
      @cells[space] = Cell.new(space)
    end
    @cells
  end

  def valid_placement?(ship_name, coordinates_array)
    horizontal = coordinates_array.map { |x| x.delete("ABCDEFGHIJKLMNOPQRSTUVWXYZ").to_i }
    vertical = coordinates_array.map { |coordinate| coordinate.delete("1234567890") }
    vertical = vertical.map! { |letter| letter.ord }
    ((1..4).each_cons(ship_name.length).to_a.include?(horizontal) && vertical.uniq.length == 1) ||
    ((65..68).each_cons(ship_name.length).to_a.include?(vertical) && horizontal.uniq.length == 1)
  end

  def ship_does_not_exist_on_cell(coordinates_array)
    coordinates_array.all? { |coord| @cells[coord].ship == nil }
  end

  def place(ship_name, coordinates_array)
    if (valid_placement?(ship_name, coordinates_array) == true) && ship_does_not_exist_on_cell(coordinates_array) == true
      coordinates_array.each do |coord|
        @cells[coord].place_ship(ship_name)
      end
    else
      nil
    end
  end

 def render(player = false)
   if player == false
     render_array = @cells.values.map do |cell|
       cell.render + " "
    end
    x = ["1 ", "2 ", "3 ", "4 "]
    flat_array = render_array.unshift(x).flatten
    array_2 = flat_array.each_slice(4).to_a.map { |slice| slice << "\n"}
    array = [["  "], ["A "], ["B "], ["C "], ["D "]]
    output = array.map { |slice| slice << array_2.shift }.flatten.join
    output
   else
     render_array = @cells.values.map do |cell|
       cell.render(true) + " "
    end
    x = ["1 ", "2 ", "3 ", "4 "]
    flat_array = render_array.unshift(x).flatten
    array_2 = flat_array.each_slice(4).to_a.map { |slice| slice << "\n"}
    array = [["  "], ["A "], ["B "], ["C "], ["D "]]
    output = array.map { |slice| slice << array_2.shift }.flatten.join
    output
   end
 end

end
