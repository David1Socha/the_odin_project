class Board
  CONNECT_LENGTH = 4
  attr_accessor :contents

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
    return !@contents.any? {|row| row.any? {|element| element.nil?} }
  end

end

class Player
  
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @won = false
  end

  def won?
    return @won
  end

  def won=(won)
    @won = won
  end

end