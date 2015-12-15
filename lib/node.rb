require 'pry'

class Node
  attr_accessor :links, :word, :weight

  def initialize(word = false, links = {} , weight = 0)
    @links = links
    @word = word
    @weight = weight
  end

end
