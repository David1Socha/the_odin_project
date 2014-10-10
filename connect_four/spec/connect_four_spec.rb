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

  describe "#lowest_empty_row_index" do

    before(:each) do
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

  describe "#place_symbol" do

    before(:each) do
      @board = Board.new(7, 8)
    end
    
    it "adds specified symbol to lowest empty row in column" do
      allow(@board).to receive(:lowest_empty_row_index).and_return(7)
      @board.place_symbol(1, :O)
      expect(@board.contents[7][1]).to eq(:O)
    end

    it "does nothing if entire column is full" do
      allow(@board).to receive(:lowest_empty_row_index).and_return(nil)
      old_contents = Array.new(@board.contents)
      @board.place_symbol(0, :X)
      expect(@board.contents).to eq(old_contents)
    end

  end

end
