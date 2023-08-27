class Board
  TRANSFORMATIONS = [[1, 2], [-2, -1], [-1, 2], [2, -1],
  [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  # An array of all visisted locations
  @@history = []

  # Accessor for history class variable
  def history
   @@history
  end

  def create_children(parent_node)
    # Apply transformations to the knight's location and return array of possible locations
    locations = TRANSFORMATIONS.map { |t| [parent_node.position[0] + t[0], parent_node.position[1] + t[1]] }

    # Remove any postions that are not valid chess board coordinates
    locations = locations.keep_if { |loc| valid_position?(loc) }

    # Reject any posititon that is in the history array
    locations = locations.reject { |loc| @@history.include?(loc) } 

    # Create child node from valid locations
    locations = locations.map { |loc| Knight.new(loc, parent_node)}
  end

  def valid_position?(position)
    # Chess board is 8x8 grid, all position cordinates must have values between 1-8 to be valid
    position[0].between?(1, 8) && position[1].between?(1, 8)
  end

  def display_moves(node)
    display_moves(node.parent) unless node.parent.nil?
    p node.position
  end

  def count_moves(node, count = -1)
    count += 1
    return count if node.parent.nil?
    count_moves(node.parent, count)
  end

  # Returns shortest path from starting coordiantes to ending coordinates
  def knight_moves(start, end_position)
    # Create queue of possible locations of the Knight
    queue = []

    # Initalize Knight at starting position
    current_node = Knight.new(start)

    # Stop if Knight has reached desired position
    until current_node.position == end_position
      # Else add all possible moves to queue
      create_children(current_node).each { |child| queue << child}

      # Dequeue current location and move onto next possible location
      current_node = queue.shift
    end

    # Desired location has been reached, display path
    puts "You made it in #{count_moves(current_node)} moves!  Here's your path:"
    display_moves(current_node)
  end 
end

