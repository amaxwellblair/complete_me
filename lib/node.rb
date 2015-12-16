
class Node
  attr_accessor :links, :word, :weight

  def initialize(word = false, links = {})
    @links = links
    @word = word
  end

end
