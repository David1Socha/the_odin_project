class Board
  attr_accessor :contents

  def initialize(row_len, col_len)
    @contents = Array.new (col_len) { Array.new(row_len) }
  end

  def lowest_empty_row_index(col) #returns index of lowest row where specified column is empty
    low_row_index = @contents.rindex { |row| row[col].nil?}
  end

end
