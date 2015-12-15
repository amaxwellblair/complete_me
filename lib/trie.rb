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



  def create_node(word = false)
    return Node.new(word)
  end

end
