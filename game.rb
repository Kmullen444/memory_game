require_relative "board.rb"
require_relative "player.rb"
require_relative "computer_player.rb"
require "byebug"

class Game
  attr_reader :board, :pre_guess, :player

  def initialize (player, size = 4)
    @board = Board.new
    @player = player
    @pre_guess = nil

  end


  def play
    system("clear")
    self.round until @board.won?
    puts "You won!"
  end


  def round
    @board.show_board
    check(get_guess)
    @board.show_board
    check(get_guess)
    sleep(1)
    @player.previous_guess = nil
    @pre_guess = nil
  end


  def check (guess)
    if @pre_guess.nil?
      @pre_guess = guess
      @board.flip(@pre_guess)
      @player.receive_reveal_cards(guess, @board[guess])
    else
      @board.flip(guess)
      @player.receive_reveal_cards(guess, @board[guess])
      @board.show_board
      unless match?(guess)
        [@pre_guess, guess].each { |pos| @board.hide(pos)}
      else
        @player.receive_match(guess, @pre_guess)
      end
    end
  end

  def match?(guess)
    @board[guess].letter == @board[@pre_guess].letter
  end

  def get_guess
    player_guess = @player.guess
    until is_valid?(player_guess) && !@board[player_guess].flipped? 
      puts "That's not a valid input please guess again"
      player_guess = @player.guess
    end
    player_guess
  end

  def is_valid?(pos)
    row, col = pos
    return false if (row < 0 || row > @board.size - 1) || (col < 0 || col > @board.size - 1)
    true
  end


end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Computer_player.new(4))
  game.play
end