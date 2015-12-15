$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'node'

class NodeTest < Minitest::Test
  attr_reader :the_node

  def setup
    skip
    @the_node = Node.new
  end

  def test_empty_links
    skip
    assert_equal ({}), the_node.links
  end

  def test_empty_word
    skip
    assert_equal false, the_node.word
  end

  def test_empty_weight
    skip
    assert_equal 0, the_node.weight
  end

end
