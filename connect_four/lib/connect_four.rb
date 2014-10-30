class Board
  CONNECT_LENGTH = 4
  attr_accessor :contents
  attr_reader :rows, :cols

  def initialize(row_len, col_len)
    @rows = col_len
    @cols = row_len
    @contents = Array.new (col_len) { Array.new(row_len) }
  end

  def lowest_empty_row_index(col) #returns index of lowest row where specified column is empty
    low_row_index = @contents.rindex { |row| row[col].nil?}
  end

  def place_symbol(col, symbol)
    row = lowest_empty_row_index(col)
    @contents[row][col] = symbol unless row.nil?
    return row, col
  end

  def col_range(col)
    (col - CONNECT_LENGTH .. col + CONNECT_LENGTH)
  end

  def row_range(row)
    (row - CONNECT_LENGTH .. row + CONNECT_LENGTH)
  end

  def has_won_vertical?(row, col, symbol)
    row_range(row).each_cons(CONNECT_LENGTH) do |set| 
      return true if set.all? {|r| (r >= 0 && r < @rows) && @contents[r][col] == symbol}
    end
    return false
  end

  def has_won_horizontal?(row, col, symbol)
    col_range(col).each_cons(CONNECT_LENGTH) do |set| 
      return true if set.all? {|c| @contents[row][c] == symbol}
    end
    return false
  end

  def has_won_antidiagonal?(row, col, symbol)
    row_range(row).zip(col_range(col).reverse_each).each_cons(CONNECT_LENGTH) do |set|
      return true if set.all? {|rowcol| (rowcol.first >= 0 && rowcol.first < @rows) && @contents[rowcol.first][rowcol.last] == symbol}
    end
    return false
  end

  def has_won_diagonal?(row, col, symbol)
    row_range(row).zip(col_range(col)).each_cons(CONNECT_LENGTH) do |set|
      return true if set.all? {|rowcol| (rowcol.first >= 0 && rowcol.first < @rows) && @contents[rowcol.first][rowcol.last] == symbol}
    end
    return false
  end

  def has_won?(row, col, symbol) 
    return has_won_diagonal?(row, col, symbol) || has_won_antidiagonal?(row, col, symbol) || has_won_horizontal?(row, col, symbol) || has_won_vertical?(row, col, symbol)
  end

  def full?
    @cols.times do |c|
      if !column_full?(c)
        return false
      end
    end
    return true
  end

  def column_full?(col) #assumes board is result of valid connect four moves
    return !@contents[0][col].nil?
  end

  def to_s
    board_str = ""
    @contents.each do |row|
      row_str = row.map{|e| e.nil? ? " " : e }.join(" ")
      board_str << "|#{row_str}|\n"
    end
    board_str
  end

end

class HumanPlayer
  
  attr_accessor :name, :symbol, :won
  alias_method :won?, :won

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @won = false
  end

  def get_move(board)
    valid_input = false
    puts "Current Board:", board
    until valid_input
      begin
        puts "In which column would you like to place a piece?"
        move = gets.chomp
        int_move = Integer(move, 10)
        if int_move < 0 || int_move >= board.cols
          puts "Column is out of range"
        elsif board.column_full?(int_move)
          puts "Column is full"
        else
          valid_input = true
        end
      rescue
        puts "Please enter a valid integer"
      end
    end
    return int_move
  end
end

class Game
  
  attr_accessor :players, :board
  
  def initialize(row_len, col_len, *players)
    @players = players
    @board = Board.new(row_len, col_len)
  end

  def run_turn(player)
    col = player.get_move(@board)
    row, col = @board.place_symbol(col, player.symbol)
    player.won = @board.has_won?(row, col, player.symbol)
  end
  
end