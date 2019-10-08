require 'minitest/autorun'
require 'minitest/pride'
require 'Users/hlevin/turing/mod_1/battleship/lib/ship'

class ShipTest < Minitest::Test
  def setup
    @ship = Ship.new("Cruiser", 3)
  end

  def test_for_instance_of_ship
    assert_instance_of Ship, @ship
  end

  def test_for_name_of_ship
    assert_equal 3, @ship.length
  end

  def test_initial_health_level
    assert_equal 3, @ship.health
  end
  
  def test_if_ship_is_hit_and_health_level
    @ship.hit
    assert_equal 2, @ship.health
    @ship.hit
    assert_equal 1, @ship.health
  end

  def test_if_ship_is_sunk
    @ship.hit
    assert_equal false, @ship.health
    @ship.hit
    assert_equal false, @ship.health
    @ship.hit
    assert_equal true, @ship.health
  end
end
