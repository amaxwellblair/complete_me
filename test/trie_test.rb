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
    the_trie.insert("")
    assert_equal ({}), the_trie.root.links
  end

  def test_insert_nil
    the_trie.insert(nil)
    assert_equal ({}), the_trie.root.links
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
    the_trie.insert("a")
    assert_equal true, the_trie.root.links["a"].word
  end

  def test_insert_word_false
    the_trie.insert("at")
    assert_equal false, the_trie.root.links["a"].word
  end

  def test_insert_two_words_true
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
    assert_equal true, the_trie.find_given_substring_trie(%w(c a t)).word
  end


  def test_find_given_word_trie_verify
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal ["a", "h"], the_trie.find_given_substring_trie(%w(c)).links.keys
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
    assert_equal ["Hilarious"], the_trie.combine_substring_with_suffix("Hi",["larious"])
  end

  def test_words_questions
    the_trie.insert("a")
    the_trie.insert("at")
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal true, the_trie.word?("cattie")
  end

  def test_words_questions_false
    the_trie.insert("a")
    the_trie.insert("at")
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    assert_equal false, the_trie.word?("catty")
  end


  def test_retrieve_word_other
    the_trie.insert("cat")
    the_trie.insert("cattie")
    the_trie.insert("chicken")
    the_trie.insert("cm")
    assert_equal ["cat", 'cattie'], the_trie.find_suggestions("ca")
  end

  def test_retrieve_word
    the_trie.insert("at")
    assert_equal ["at"], the_trie.find_suggestions("a")
  end

  def test_weighted_selections
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("atom")
    the_trie.selects("a", "at")
    assert_equal ["at", "a", "atom"], the_trie.find_suggestions("a")
  end

  def test_weighted_selections_num_two
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("atom")
    the_trie.selects("a", "at")
    the_trie.selects("a", "atom")
    the_trie.selects("a", "atom")
    assert_equal ["atom", "at", "a"], the_trie.find_suggestions("a")
  end


  def test_weighted_selections_not_selected
    the_trie.insert("at")
    the_trie.insert("a")
    the_trie.insert("atom")
    the_trie.selects("a", "at")
    the_trie.selects("a", "atom")
    the_trie.selects("a", "atom")
    assert_equal ["at", "atom"], the_trie.find_suggestions("at")
  end

  def test_weighted_edge_case
    skip
    #nil, blank, etc
  end



  def test_nil_case
    skip
    #insert nil, blank, same word, other edge cases
  end


end
