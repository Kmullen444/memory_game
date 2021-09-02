class Card
  attr_reader :flipped, :letter

  def initialize(letter, flipped = false)
    @flipped = flipped
    @letter = letter
  end

  def hide
    @flipped = false
  end

  def show
    @flipped = true
  end
  
  def flipped?
    @flipped
  end

  def to_s
    flipped?? letter.to_s : " "
  end

  def ==(object)
    object.is_a?(self.class) && object.letter == letter
  end
end