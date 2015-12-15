require 'pry'

class Node
  attr_accessor :links, :word, :weight

  def initialize
    @links = {}
    @word = false
    @weight = 0
  end

end
