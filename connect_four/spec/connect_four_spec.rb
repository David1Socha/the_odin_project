require_relative '../lib/connect_four'

describe "Board" do
  
  describe "#new" do

    before(:all) do
      @board = Board.new(7,8)
    end

    it "returns a new board object" do
      expect(@board).to be_an_instance_of Board
    end

    it "creates rows of specified length" do
      expect(@board.contents[0].size).to eq 7
    end

    it "creates columns of specified length" do
      expect(@board.contents.size).to eq 8
    end

  end

  describe "#lowest_empty_row" do

    before(:all) do
      @board = Board.new(7,8)
    end

    it "returns nil when entire column is full" do
      @board.contents.each {|row| row[2] = :O}
      expect(@board.lowest_empty_row_index(2)).to be_nil
    end

    it "returns lowest row index when multiple rows are empty in specified column" do
      @board.contents[7][5] = :X
      expect(@board.lowest_empty_row_index(5)).to eq(6)
    end

  end

end
