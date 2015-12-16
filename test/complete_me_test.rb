$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :autocorrect

  def setup
    @autocorrect = CompleteMe.new
  end

  def test_insert
    autocorrect.insert("pizza")
    assert_equal 1, autocorrect.count
  end

  def test_insert_nothing
    skip
    autocorrect.insert("")
    assert_equal 0, autocorrect.count
  end

  def test_insert_nil
    skip
    autocorrect.insert(nil)
    assert_equal 0, autocorrect.count
  end

  def test_insert_using_suggest
    autocorrect.insert("pizza")
    assert_equal ["pizza"], autocorrect.suggest("piz")
  end

  def test_two_insert_using_suggest
    autocorrect.insert("pizza")
    autocorrect.insert("pizzeria")
    assert_equal ["pizza", "pizzeria"], autocorrect.suggest("piz")
  end

  def test_load
    dictionary = File.read("./lib/sample.txt")
    autocorrect.populate(dictionary)
    assert_equal ["pizza", "pizzeria", "pizzicato"], autocorrect.suggest("piz")
  end

  def test_load_count
    dictionary = File.read("./lib/sample.txt")
    autocorrect.populate(dictionary)
    assert_equal 20, autocorrect.count
  end

end
