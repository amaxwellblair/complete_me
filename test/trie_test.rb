$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'trie'

class TrieTest < Minitest::Test
  attr_reader :the_trie

  def setup
    skip
    @the_trie = Trie.new
  end

  def test_insert_nothing
    skip
    the_trie.insert("")
    assert_equal the_trie.root.links, ({})
  end

  def test_insert_nil
    skip
    the_trie.insert(nil)
    assert_equal ({}), the_trie.root.links
  end

  def test_insert_node
    skip
    the_trie.insert("a")
    assert_equal ({"a" => nil}), the_trie.root.links
  end

  def test_insert_word
    skip
    the_trie.insert("at")
    assert_equal ["a"], the_trie.root.links.keys
    assert_equal ["t"], the_trie.root.links["a"].links.keys
  end

  def test_insert_word_true
    skip
    the_trie.insert("a")
    assert_equal true, the_trie.root.links["a"].word
  end

  def test_insert_word_false
    skip
    the_trie.insert("at")
    assert_equal false, the_trie.root.links["a"].word
  end

  def test_insert_two_words_true
    skip
    the_trie.insert("at")
    the_trie.insert("a")
    assert_equal true, the_trie.root.links["a"].word
  end

  def test_retrieve_word
    skip
    the_trie.insert("at")
    assert_equal ["at"], the_trie.find_suggestions("a")
  end

  def test_select_word_weight
    skip
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.selects("a", "at")
    assert_equal 1, the_trie.root.links["a"].links.weight
  end

  def test_return_selections
    skip
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("atom")
    assert_equal ["a", "at", "atom"], the_trie.find_suggestions("a")
  end

  def test_weighted_selections
    skip
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("atom")
    the_trie.root.links["a"].links.weight = 10
    assert_equal ["at", "a", "atom"], the_trie.find_suggestions("a")
  end


end
