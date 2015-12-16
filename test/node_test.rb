$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'node'

class NodeTest < Minitest::Test
  attr_reader :the_node

  def setup
    @the_node = Node.new
  end

  def test_empty_links
    assert_equal ({}), the_node.links
  end

  def test_empty_word
    assert_equal false, the_node.word
  end

end
