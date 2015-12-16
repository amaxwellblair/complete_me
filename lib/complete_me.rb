require 'minitest'
require_relative 'trie'

class CompleteMe
  attr_reader :trie

  def initialize
    @trie = create_trie
  end

  def create_trie
    Trie.new
  end

  def insert(word)
    trie.insert(word)
  end

  def count
    trie.word_count
  end

  def suggest(word)
    trie.find_suggestions(word)
  end

  def populate(dictionary)
    dictionary = dictionary.split("\n")
    dictionary.each do |word|
      insert(word)
    end
    count
  end

  def select(substring, suggestion)
    trie.selects(substring, suggestion)
  end

end
