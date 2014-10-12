require_relative '../lib/connect_four'

describe "Board" do
  
  describe "#new" do

    before(:all) do
      @board = Board.new(3,2)
    end

    it "returns a new board object" do
      expect(@board).to be_an_instance_of Board
    end

    it "creates rows of specified length" do
      expect(@board.contents[0].size).to eq 3
    end

    it "creates columns of specified length" do
      expect(@board.contents.size).to eq 2
    end

  end

  describe "#lowest_empty_row_index" do

    before(:each) do
      @board = Board.new(6,7)
    end

    it "returns nil when entire column is full" do
      @board.contents.each {|row| row[2] = :O}
      expect(@board.lowest_empty_row_index(2)).to be_nil
    end

    it "returns lowest row index when multiple rows are empty in specified column" do
      @board.contents[6][5] = :X
      expect(@board.lowest_empty_row_index(5)).to eq(5)
    end

  end

  describe "#place_symbol" do

    before(:each) do
      @board = Board.new(6, 7)
    end
    
    it "adds specified symbol to lowest empty row in column" do
      allow(@board).to receive(:lowest_empty_row_index).and_return(6)
      @board.place_symbol(1, :O)
      expect(@board.contents[6][1]).to eq(:O)
    end

    it "does nothing if entire column is full" do
      allow(@board).to receive(:lowest_empty_row_index).and_return(nil)
      old_contents = Array.new(@board.contents)
      @board.place_symbol(0, :X)
      expect(@board.contents).to eq(old_contents)
    end

  end

  describe "#has_won_vertical?" do

    before(:each) do
      @board = Board.new(6, 7)
    end

    it "returns true when four consecutive vertical positions contain specified symbol" do
      @board.contents[3][2] = :Q
      @board.contents[4][2] = :Q
      @board.contents[5][2] = :Q
      @board.contents[6][2] = :Q
      expect(@board.has_won_vertical?(3,2,:Q)).to be true
    end

    it "returns false when there are not enough elements below last-placed symbol for connection to be formed" do
      @board.contents[4][4] = :X
      @board.contents[5][4] = :X
      @board.contents[6][4] = :X
      expect(@board.has_won_vertical?(4,4, :X)).to be false
    end

    it "returns false when fewer than four consecutive vertical positions contain specified symbol" do
      @board.contents[3][2] = :P
      @board.contents[4][2] = :Q
      @board.contents[5][2] = :Q
      @board.contents[6][2] = :Q
      expect(@board.has_won_vertical?(3,2,:P)).to be false
    end

  end

end
