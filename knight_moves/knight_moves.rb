#Given the current position and target location of a knight on a chessboard, lists a path of minimum length from origin to destination
BOARD_WIDTH = 8

def knight_moves(origin, goal)
  #locations = initialize_locations
  current_loc = Location.new(origin.first, origin.last)
  goal_loc = Location.new(goal.first, goal.last)
  moves = [current_loc]
  goal_found = false
  until goal_found do
    if current_loc == goal_loc #end loop once valid path has been found
      goal_found = true
    else
      moves = moves | current_loc.get_potential_moves.each {|loc| loc.origin = current_loc}
      current_loc = moves.shift
    end
  end

  path = []
  until current_loc.nil? do #trace back path 
    path << current_loc
    current_loc = current_loc.origin
  end

  path_array = []
  path.reverse_each do |loc|
    path_array << loc.to_a
  end
  return path_array

end

def initialize_locations
  locations = Array.new(BOARD_WIDTH)
  locations.each_with_index do |row, i|
    row = Array.new(BOARD_WIDTH)
    row.each_index do |j|
      row[j] = Location.new(i,j)
    end
  end
end

class Location
  attr_accessor :row, :col, :origin, :visited
  alias_method :visited?, :visited

  def initialize(row, col)
    @row = row
    @col = col
  end

  def get_potential_moves
    select_valid_moves(
      Location.new((@row-1),(@col-2)), Location.new((@row-2),(@col-1)),
      Location.new((@row+1),(@col-2)), Location.new((@row-1),(@col+2)),
      Location.new((@row+2),(@col-1)), Location.new((@row-2),(@col+1)),
      Location.new((@row+1),(@col+2)), Location.new((@row+2),(@col+1)) )
  end

  def select_valid_moves( *points)
    moves = []
    points.each do |p|
      unless p.nil? || p.visited
        moves << p 
        p.visited = true
      end
    end
    return moves
  end

  def ==(other_location)
    return @row == other_location.row && @col == other_location.col
  end

  def to_a
    return [@row, @col]
  end

end


#Tests
path1 = knight_moves([0,0],[3,3])
path1.map! {|loc| "[#{loc.first},#{loc.last}]"}
puts "Path from [0,0] to [3,3] is:", path1
path2 = knight_moves([3,3],[4,3])
path2.map! {|loc| "[#{loc.first},#{loc.last}]"}
puts "Path from [3,3] to [4,3] is:", path2