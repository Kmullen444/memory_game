require_relative "card.rb"
require "byebug"

class Board
  attr_reader :size, :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) }
    @size = @grid.length
    populate
  end

  def show_board
    system("clear")
    puts "  #{show_row.join(" ")}"
    puts show_col
  end

  def show_row
    (0...size).map { |num| num }
  end

  def show_col
    (0...size).map { |i| "#{i} #{grid[i].join(" ")}" }
  end

  def make_cards
      alp = ("A".."Z").to_a
    
      cards_arr = []
      letter_range = alp[0...(@size * 2)]
      count = 0
      while count < @size * @size
        letter = letter_range[count % 8]
        cards_arr << Card.new(letter)
        count += 1
      end 
    cards_arr
  end

  def populate
    cards = make_cards
    count = 0 

    while count < grid_size
      pos = self.random_indices
      if empty?(pos)
        @grid[pos[0]][pos[1]] = cards[count]
        count += 1
      else
        false
      end
    end
  end

  def flip(pos)
    self[pos].show
    self[pos].letter
  end

  def hide(pos)
    self[pos].hide
  end

  def grid_size
    @size * @size
  end

  def empty?(pos)
    row, col = pos
    @grid[row][col].nil?
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def flipped?(pos)
    self[pos].flipped?
  end

  def random_indices
    [rand(0...@size), rand(0...@size)]
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.flipped?}
    end
  end
end