require "pry"

class Memory
  attr_accessor :bank
  def initialize
    @bank = {}
  end

  def insert(substring, selection)
    weight = 0
    if bank[substring].nil?
      bank[substring] = {selection => weight}
    elsif bank[substring][selection].nil?
      bank[substring][selection] = weight
    else
      bank[substring][selection] -= 1
    end
  end

end
