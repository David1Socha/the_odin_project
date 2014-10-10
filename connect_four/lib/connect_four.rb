class Board
  attr_accessor :contents

  def initialize(row_len, col_len)
    @contents = Array.new (col_len) { Array.new(row_len) }
  end
end
