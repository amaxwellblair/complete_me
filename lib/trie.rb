require 'pry'
require 'node'
require 'memory'

class Trie
  attr_reader :root

  def initialize
    @root = create_node
    @memory_bank = create_memory_bank
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

  def select(word, selection)
    memory_bank.insert(word,selection)
  end

  def create_node(word = false)
    return Node.new(word)
  end

  def create_memory_bank
    return Memory.new
  end

  def find_suggestions(word)
    letter_array = word.chars
    desired_trie = find_given_word_trie(letter_array)
    suggested_suffix = find_suffix_in_trie(desired_trie)
    combine_word_with_pieces(word, suggested_suffix)
  end

  def combine_word_with_pieces(word, pieces)
    pieces.map do |piece|
      word + piece
    end
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

  def find_suffix_in_trie(node, suffix_array = [], suffix = "")
    if node.links.nil?
      nil
    else
      suffix_array = iterate_through_links_find(node, suffix_array, suffix)
    end
    suffix_array
  end

  def iterate_through_links_find(node, suffix_array, suffix)
    node.links.each do |key, value|
      suffix += key
      if value.word == true
        suffix_array << suffix
      end
      find_suffix_in_trie(value, suffix_array, suffix)
      suffix = suffix.chop
    end
    suffix_array
  end

end
