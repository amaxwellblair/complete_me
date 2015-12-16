$LOAD_PATH.unshift("./lib/")
require 'minitest'
require 'trie'

class CompleteMe
  attr_reader :trie

  def initialize
    @trie = create_trie
  end

  def create_trie
    Trie.new
  end
