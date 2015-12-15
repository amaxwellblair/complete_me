require 'pry'
require 'node'

class Trie
  attr_reader :root

  def initialize
    @root = create_node
  end

  def insert(word)
    letter_array = word.chars
    letter_insert(letter_array)
  end

  def letter_insert(letter_array, node = root)
    letter = letter_array.shift
    if letter_array.empty?
      if node.links[letter].nil?
        node.links[letter] = create_node(true)
      else
        node.links[letter].word = true
      end
    else
      node.links[letter] = create_node if node.links[letter].nil?
      letter_insert(letter_array, node.links[letter])
    end
  end

  def word_count(node = root, current_count = 0)
    if node.links.nil?
      nil
    else
      current_count = iterate_through_links_count(node, current_count)
    end
    current_count
  end

  def iterate_through_links_count(node, current_count)
    node.links.each do |key, value|
      if value.word == true
        current_count += 1
      end
      current_count = word_count(value, current_count)
    end
    current_count
  end

  def create_node(word = false)
    return Node.new(word)
  end

  def find_suggestions(word)
    letter_array = word.chars
    desired_trie = find_given_word_trie(letter_array)
    find_words_in_trie(desired_trie)
  end

  def find_given_word_trie(letter_array, node = root)
    letter = letter_array.shift
    if node.links[letter].nil?
      return nil
    elsif letter_array.empty?
      return node.links[letter]
    else
       find_given_word_trie(letter_array, node.links[letter])
    end
  end

  def find_words_in_trie(node, word_array = [], word = "")
    if node.links.nil?
      nil
    else
      word_array = iterate_through_links_find(node, word_array, word)
    end
    word_array
  end

  def iterate_through_links_find(node, word_array, word)
    node.links.each do |key, value|
      word += key
      if value.word == true
        word_array << word
      end
      find_words_in_trie(value, word_array, word)
      word = word.chop
    end
    word_array
  end

end
