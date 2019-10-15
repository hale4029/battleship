require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells, :dimensions

  def initialize(dimensions = 10)
    @dimensions = dimensions
    letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ord.chr}
    letters = (letters * @dimensions).sort
    numbers = (1..(1 + (@dimensions - 1))).to_a
    numbers = numbers * @dimensions
    hash = {}
    letters.each { |letter| hash[letter] = numbers }
    @spaces = numbers.map { |x| "#{letters.shift}#{x}"  }
    @cells = {}
    @spaces.each { |space| @cells[space] = Cell.new(space) }
    @cells
  end

  def valid_placement?(ship_name, coordinates_array)
    horizontal = coordinates_array.map { |x| x.delete("ABCDEFGHIJKLMNOPQRSTUVWXYZ").to_i }
    vertical = coordinates_array.map { |coordinate| coordinate.delete("1234567890") }
    vertical = vertical.map! { |letter| letter.ord }
    ((1..(1 + (@dimensions - 1))).each_cons(ship_name.length).to_a.include?(horizontal) && vertical.uniq.length == 1) ||
    ((65..(65 + (@dimensions - 1))).each_cons(ship_name.length).to_a.include?(vertical) && horizontal.uniq.length == 1)
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
    numbers = (1..(1 + (@dimensions - 1))).to_a
    numbers = numbers.map { |x| "#{x.to_s} "}
    flat_array = render_array.unshift(numbers).flatten
    array_2 = flat_array.each_slice(@dimensions).to_a.map { |slice| slice << "\n"}
    letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ["#{ord.chr} "]}
    letters.unshift(["  "])
    letters.map { |slice| slice << array_2.shift }.flatten.join
   else
     render_array = @cells.values.map do |cell|
       cell.render(true) + " "
    end
    numbers = (1..(1 + (@dimensions - 1))).to_a
    numbers = numbers.map { |x| "#{x.to_s} "}
    flat_array = render_array.unshift(numbers).flatten
    array_2 = flat_array.each_slice(@dimensions).to_a.map { |slice| slice << "\n"}
    letters = (65..(65 + (@dimensions - 1))).to_a.map { |ord| ["#{ord.chr} "]}
    letters.unshift(["  "])
    letters.map { |slice| slice << array_2.shift }.flatten.join
   end
 end

end
