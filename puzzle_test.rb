require 'test/unit'
require_relative 'puzzle.rb'

class TestPuzzle < Test::Unit::TestCase
  def setup
    @puzzle = Puzzle.new( 3, 3 )
    @puzzle4x4 = Puzzle.new( 4, 4 )
  end

  def test_class
    assert_equal( Puzzle, @puzzle.class, "Testing object class")
    assert_equal( 3, @puzzle.width, "Testing width")
    assert_equal( 3,  @puzzle.height, "Testing height")
    assert_equal( 4, @puzzle4x4.width, "Testing width")
    assert_equal( 4,  @puzzle4x4.height, "Testing height")
  end

  def test_get
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "initial config")
    assert_equal( "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 _",  @puzzle4x4.get_puzzle, "initial config (4x4 puzzle)")
  end

  def test_set
    assert_not_equal(true, @puzzle.set_puzzle("1 2 3 4 5 6 7 8 9 10 _"), "testing response to invalid number of items for puzzle size")
    assert_not_equal(true, @puzzle.set_puzzle("1 2 3 4 5 6 7 _ _"), "testing response to too many spaces in puzzle")
    assert_not_equal(true, @puzzle.set_puzzle("1 2 3 4 5 6 7 8 9"), "testing response to no spaces in puzzle")
    @puzzle.set_puzzle("1 2 _ 3 4 5 6 7 8")
    assert_equal("1 2 _ 3 4 5 6 7 8", @puzzle.get_puzzle, "testing set_puzzle correctly populated puzzle")
    @puzzle.set_puzzle("3 5 4 _ 7 8 2 1 6")
    assert_equal("3 5 4 _ 7 8 2 1 6", @puzzle.get_puzzle, "testing set_puzzle correctly populated puzzle")

  end

  def test_move_up
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "initial config")
    @puzzle.move_up
    assert_equal( "1 2 3 4 5 _ 7 8 6",  @puzzle.get_puzzle, "testing move up once")
    @puzzle.move_up
    assert_equal( "1 2 _ 4 5 3 7 8 6",  @puzzle.get_puzzle, "testing move up twice")
    @puzzle.move_up
    assert_equal( "1 2 _ 4 5 3 7 8 6",  @puzzle.get_puzzle, "testing no change when space in highest position")
  end

  def test_move_down
    @puzzle.set_puzzle("1 2 _ 4 5 3 7 8 6")
    assert_equal( "1 2 _ 4 5 3 7 8 6",  @puzzle.get_puzzle, "initial config")
    @puzzle.move_down
    assert_equal( "1 2 3 4 5 _ 7 8 6",  @puzzle.get_puzzle, "testing move down once")
    @puzzle.move_down
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing move down twice")
    @puzzle.move_down
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing no change when space in lowest position")

  end

  def test_move_right
    @puzzle.set_puzzle("1 2 3 4 5 6 _ 7 8")
    assert_equal( "1 2 3 4 5 6 _ 7 8",  @puzzle.get_puzzle, "initial config")
    @puzzle.move_right
    assert_equal( "1 2 3 4 5 6 7 _ 8",  @puzzle.get_puzzle, "testing move right once")
    @puzzle.move_right
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing move right twice")
    @puzzle.move_right
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing no change when space in leftmost position")

  end

  def test_move_left
    @puzzle.set_puzzle("1 2 3 4 5 6 7 8 _")
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "initial config")
    @puzzle.move_left
    assert_equal( "1 2 3 4 5 6 7 _ 8",  @puzzle.get_puzzle, "testing move left once")
    @puzzle.move_left
    assert_equal( "1 2 3 4 5 6 _ 7 8",  @puzzle.get_puzzle, "testing move left twice")
    @puzzle.move_left
    assert_equal( "1 2 3 4 5 6 _ 7 8",  @puzzle.get_puzzle, "testing no change when space in leftmost position")

  end

  def test_scramble
    @puzzle.set_puzzle("1 2 3 4 5 6 7 8 _")
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "initial config")
    @puzzle.scramble
    assert_not_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing scramble")
    @after_scramble = @puzzle.get_puzzle
    @puzzle.scramble
    assert_not_equal( @after_scramble,  @puzzle.get_puzzle, "testing scramble again")
  end

  def test_solve
    @puzzle.set_puzzle("1 2 3 4 5 6 7 8 _")
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "initial config")
    @puzzle.scramble
    assert_not_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing scramble")
    @puzzle.solve
    assert_equal( "1 2 3 4 5 6 7 8 _",  @puzzle.get_puzzle, "testing solve")
  end

  def test_solve_4x4
    @puzzle4x4.solve
    assert_equal("1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 _", @puzzle4x4.get_puzzle, "testing solve function on non 3x3 grid")
  end

end