require_relative "board.rb"

class Human_player
  attr_writer :previous_guess
  def initialize
    @previous_guess = nil
  end

  def guess
    position = []
    puts "Please enter a row"
    position << gets.chomp.to_i
    puts "Please enter a column"
    position << gets.chomp.to_i
    position 
  end

  def receive_reveal_cards(pos, value);end

  def receive_match(pos_1, pos_2);end

end