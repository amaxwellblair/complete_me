$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'trie'

class TrieTest < Minitest::Test
  attr_reader :the_trie

  def setup
    @the_trie = Trie.new
  end

  def test_trie_class
    assert_equal Trie, the_trie.class
  end

  def test_root
    assert_equal ({}), the_trie.root.links
  end

  def test_root_class
    assert_equal Node, the_trie.root.class
  end

  def test_insert_nothing
    skip
    the_trie.insert("")
    assert_equal ({}), the_trie.root.links
  end

  def test_insert_nil
    skip
    the_trie.insert(nil)
    assert_equal nil, the_trie.root
  end

  def test_insert_node
    the_trie.insert("a")
    assert_equal ["a"], the_trie.root.links.keys
  end

  def test_insert_word
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

  def test_count
    the_trie.insert("at")
    the_trie.insert("a")
    assert_equal 2, the_trie.word_count
  end

  def test_word_count_eight
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    the_trie.insert("bo")
    the_trie.insert("max")
    the_trie.insert("donkey")
    assert_equal 8, the_trie.word_count
  end

  def test_find_given_word_trie
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    the_trie.insert("bo")
    the_trie.insert("max")
    the_trie.insert("donkey")
    assert_equal true, the_trie.find_given_word_trie(%w(c a t)).word
  end


  def test_find_given_word_trie_verify
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal ["a", "h"], the_trie.find_given_word_trie(%w(c)).links.keys
  end

  def test_find_given_word_trie
    the_trie.insert("a")
    the_trie.insert("at")
    assert_equal ["a", "at"], the_trie.find_suffix_in_trie(the_trie.root)
  end

  def test_find_given_word_trie_branches
    the_trie.insert("a")
    the_trie.insert("at")
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal ["a", "at", "cat", "cattie", "chicken"], the_trie.find_suffix_in_trie(the_trie.root)
  end

  def test_combine_words
    assert_equal ["Hilarious"], the_trie.combine_word_with_pieces("Hi",["larious"])
  end


  def test_retrieve_word
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal ["cat", 'cattie'], the_trie.find_suggestions("ca")
  end

  def test_retrieve_word
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

  def test_nil_case
    skip
    #insert nil, blank, same word, other edge cases
  end


end
