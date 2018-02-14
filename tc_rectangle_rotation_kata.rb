# File: tc_simple_number.rb
require_relative 'rectangle_rotation_kata'
require 'test/unit'

# connect 4 test class
class TestRectangleRotation < Test::Unit::TestCase

  def test_rectangulate
    assert_equal([[0.5, 0.5], [-0.5, 0.5], [-0.5, -0.5], [0.5, -0.5]], rectangulate(1,1))
    assert_equal([[0.5, 1], [-0.5, 1], [-0.5, -1], [0.5, -1]], rectangulate(1,2))
    assert_equal([[2, 0.5], [-2, 0.5], [-2, -0.5], [2, -0.5]], rectangulate(4,1))
  end

  def test_rotate
    coords = [[1, 0], [0, 1]]
    assert_equal([[0, 1], [-1, 0]], rotate(coords, 90))
  end

end
