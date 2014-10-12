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

  def has_won_vertical?(row, col, symbol)
    return false if row > @rows - CONNECT_LENGTH #need enough elements for connection to exist
    CONNECT_LENGTH.times do |offset|
      return false if @contents[row+offset][col] != symbol
    end
    return true
  end

end
