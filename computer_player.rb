class Computer_player
  attr_accessor :board_size, :previous_guess

  def initialize(size)
    @known_cards = {}
    @matched_cards = {}
    @board_size = size
    @previous_guess = nil
  end

  def receive_match(pos_1, pos_2)
    @matched_cards[pos_1] = true
    @matched_cards[pos_2] = true
  end

  def receive_reveal_cards(pos, value)
    @known_cards[pos] = value
  end

  def random_indices
    [rand(0...board_size), rand(0...board_size)]
  end

  def guess
    matched_cards = self.matched_indices
    # debugger
    if matched_indices.empty? && @previous_guess.nil?
      guess = random_guess
    elsif !@previous_guess.nil? && matched_indices.empty?
      guess = random_guess
    elsif @previous_guess == matched_cards.first
      guess = matched_cards.last
    else
      guess = matched_cards.first
    end
    @previous_guess = guess
  end

  def random_guess
    guess = random_indices

    until !@matched_cards.include?(guess) && !@known_cards.include?(guess)
      guess = random_indices
    end

    guess
  end

  def matched_indices
    count = Hash.new(0)
    matched = []

    @known_cards.values.each { |value| count[value.letter] += 1}
    matching = count.select { |key, value| key if value == 2}
    @known_cards.map do |key, value|
      if matching.has_key?(value.letter) && !@matched_cards.include?(key)
        matched << key
      end
    end
    matched
  end

end