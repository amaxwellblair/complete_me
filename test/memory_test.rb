$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'memory'
require 'pry'

class MemoryTest < Minitest::Test
  attr_reader :the_bank
  def setup
    @the_bank = Memory.new
  end

  def test_memory_class
    assert_equal Memory, the_bank.class
  end

  def test_memory_bank_call_empty
    assert_equal ({}), the_bank.bank
  end

  def test_memory_insert_one
    the_bank.insert("a", "at")
    assert_equal ({"a" => {"at" => 1}}), the_bank.bank
  end

  def test_memory_insert_two_same
    the_bank.insert("a", "at")
    the_bank.insert("a", "at")
    assert_equal ({"a" => {"at" => 2}}), the_bank.bank
  end

  def test_memory_insert_two_diff_letters
    the_bank.insert("a", "at")
    the_bank.insert("c", "cat")
    assert_equal ({"a" => {"at" => 1}, "c" => {"cat" => 1}}), the_bank.bank
  end

  def test_memory_insert_two_diff
    the_bank.insert("a", "at")
    the_bank.insert("a", "attic")
    assert_equal ({"a" => {"at" => 1, "attic" => 1}}), the_bank.bank
  end

  def test_memory_edge_cases
    skip
    #nil, blank, etc
  end

end
