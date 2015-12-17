require_relative 'node'
require_relative 'memory'

class Trie
  attr_reader :root, :memory_bank

  def initialize
    @root = create_node
    @memory_bank = create_memory_bank
  end

  def insert(word)
    if data_invalid?(word)
      puts "Data invalid"
    else
      letter_array = word.chars
      insert_each_letter(letter_array)
    end
  end

  def insert_each_letter(letter_array, node = root)
    letter = letter_array.shift
    if letter_array.empty?
      if node.links[letter].nil?
        node.links[letter] = create_node(true)
      else
        node.links[letter].word = true
      end
    else
      node.links[letter] = create_node if node.links[letter].nil?
      insert_each_letter(letter_array, node.links[letter])
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

  def selects(word, selection)
    if data_invalid?(word)
      puts "Data invalid"
    else
      memory_bank.insert(word,selection)
    end
  end

  def find_suggestions(substring)
    letter_array = substring.chars
    desired_trie = find_given_substring_trie(letter_array)
    suggested_suffix = find_suffix_in_trie(desired_trie)
    unweighted_suggestions = combine_substring_with_suffix(substring, suggested_suffix)
    weight_suggestions(unweighted_suggestions, substring)
  end

  def weight_suggestions(unweighted_suggestions, substring)
    if memory_bank.bank[substring].nil?
        unweighted_suggestions
    else
      weighted_suggestions = sort_weights(memory_bank.bank[substring])
      weighted_suggestions += unweighted_suggestions
      weighted_suggestions = weighted_suggestions.uniq
    end
  end

  def sort_weights(weighted_hash)
    weighted_words = weighted_hash.keys
    weighted_index = weighted_hash.values
    weighted_words.sort_by.with_index do |word, i|
      weighted_index[i]
    end
  end

  def combine_substring_with_suffix(substring, suffixes)
    suffixes.unshift("") if word?(substring)
    suffixes.map do |suffix|
      substring + suffix
    end
  end

  def word?(word)
    if data_invalid?(word)
      puts "Data invalid"
    else
      word_iteration(word.chars, node = root)
    end
  end

  def word_iteration(letters, node)
    letter = letters.shift
    if node.links[letter].nil?
      return false
    elsif letters.empty?
      return node.links[letter].word
    else
      word_iteration(letters,node.links[letter])
    end
  end

  def find_given_substring_trie(letter_array, node = root)
    letter = letter_array.shift
    if node.links[letter].nil?
      return nil
    elsif letter_array.empty?
      return node.links[letter]
    else
       find_given_substring_trie(letter_array, node.links[letter])
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

  def data_invalid?(word)
    if word == ""
      true
    elsif word == nil
      true
    elsif word.class != String
      true
    else
      false
    end
  end

  def create_node(word = false)
    return Node.new(word)
  end

  def create_memory_bank
    return Memory.new
  end

end
