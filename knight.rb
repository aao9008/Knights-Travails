class Knight
  def initialize(position, parent = nil)
    # Current location on the game board
    @position = position
    # A pointer to its origin (previous position)
    @parent = parent
    # Push postion to history array in game board class
    Board.new.history.push(position)
  end

  attr_accessor :position, :parent
end 