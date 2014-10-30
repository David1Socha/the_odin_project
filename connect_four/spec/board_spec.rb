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
      @board = Board.new(7, 6)
    end

    it "returns nil when entire column is full" do
      @board.contents.each {|row| row[2] = :O}
      expect(@board.lowest_empty_row_index(2)).to be_nil
    end

    it "returns lowest row index when multiple rows are empty in specified column" do
      @board.contents[5][5] = :X
      expect(@board.lowest_empty_row_index(5)).to eq(4)
    end

  end

  describe "#place_symbol" do

    before(:each) do
      @board = Board.new(7, 6)
    end
    
    it "adds specified symbol to lowest empty row in column" do
      expect(@board).to receive(:lowest_empty_row_index).and_return(5)
      @board.place_symbol(1, :O)
      expect(@board.contents[5][1]).to eq(:O)
    end

    it "does nothing if entire column is full" do
      expect(@board).to receive(:lowest_empty_row_index).and_return(nil)
      old_contents = Array.new(@board.contents)
      @board.place_symbol(0, :X)
      expect(@board.contents).to eq(old_contents)
    end

  end

  describe "#has_won_vertical?" do

    before(:each) do
      @board = Board.new(7,6)
    end

    it "returns true when four consecutive vertical positions contain specified symbol" do
      @board.contents[2][2] = :Q
      @board.contents[3][2] = :Q
      @board.contents[4][2] = :Q
      @board.contents[5][2] = :Q
      expect(@board.has_won_vertical?(2,2,:Q)).to be true
    end

    it "returns false when there are not enough elements below last-placed symbol for connection to be formed" do
      @board.contents[3][4] = :X
      @board.contents[4][4] = :X
      @board.contents[5][4] = :X
      expect(@board.has_won_vertical?(3,4, :X)).to be false
    end

    it "returns false when fewer than four consecutive vertical positions contain specified symbol" do
      @board.contents[2][2] = :P
      @board.contents[3][2] = :Q
      @board.contents[4][2] = :Q
      @board.contents[5][2] = :Q
      expect(@board.has_won_vertical?(2,2,:P)).to be false
    end

  end

  describe "#has_won_horizontal?" do 

    before(:each) do
      @board = Board.new(7,6)
    end

    it "returns true when four consecutive horizontal positions contain specified symbol" do
      @board.contents[4][2] = :X
      @board.contents[4][3] = :X
      @board.contents[4][4] = :X
      @board.contents[4][5] = :X
      expect(@board.has_won_horizontal?(4,3, :X)).to be true
    end

    it "returns false when less than four consecutive horizontal positions contain specified symbol" do
      @board.contents[4][2] = :O
      @board.contents[4][3] = :X
      @board.contents[4][4] = :X
      @board.contents[4][5] = :X
      @board.contents[4][6] = :O
      expect(@board.has_won_horizontal?(4,3, :X)).to be false
    end

  end

  describe "#has_won_antidiagonal?" do 

    before(:each) do
      @board = Board.new(7,6)
    end

    it "returns true when four consecutive antidiagonal positions contain specified symbol" do
      @board.contents[4][2] = :X
      @board.contents[3][3] = :X
      @board.contents[2][4] = :X
      @board.contents[1][5] = :X
      expect(@board.has_won_antidiagonal?(3,3, :X)).to be true
    end

    it "returns false when less than four consecutive antidiagonal positions contain specified symbol" do
      @board.contents[4][2] = :X
      @board.contents[3][3] = :X
      @board.contents[2][4] = :X
      expect(@board.has_won_antidiagonal?(3,3, :X)).to be false
    end

  end  

  describe "#has_won_diagonal?" do 

    before(:each) do
      @board = Board.new(7,6)
    end

    it "returns true when four consecutive diagonal positions contain specified symbol" do
      @board.contents[1][2] = :X
      @board.contents[2][3] = :X
      @board.contents[3][4] = :X
      @board.contents[4][5] = :X
      expect(@board.has_won_diagonal?(4,5, :X)).to be true
    end

    it "returns false when less than four consecutive diagonal positions contain specified symbol" do
      @board.contents[2][2] = :X
      @board.contents[3][3] = :X
      @board.contents[4][4] = :X
      expect(@board.has_won_diagonal?(3,3, :X)).to be false
    end

  end

  describe "#has_won?" do 

    before(:each) do
      @board = Board.new(7,6)
    end

    it "returns true when diagonal victory exists at specified location" do
      expect(@board).to receive(:has_won_diagonal?).and_return(true)
      expect(@board.has_won?(4,5, :X)).to be true
    end

    it "returns true when antidiagonal victory exists at specified location" do
      expect(@board).to receive(:has_won_antidiagonal?).and_return(true)
      expect(@board.has_won?(3,3, :X)).to be true
    end

    it "returns true when horizontal victory exists at specified location" do
      expect(@board).to receive(:has_won_horizontal?).and_return(true)
      expect(@board.has_won?(3,3, :X)).to be true
    end

    it "returns true when vertical victory exists at specified location" do
      expect(@board).to receive(:has_won_vertical?).and_return(true)
      expect(@board.has_won?(3,3, :X)).to be true
    end

    it "returns false when no victory exists at specified location" do
      expect(@board).to receive(:has_won_vertical?).and_return(false)
      expect(@board).to receive(:has_won_horizontal?).and_return(false)
      expect(@board).to receive(:has_won_diagonal?).and_return(false)
      expect(@board).to receive(:has_won_antidiagonal?).and_return(false)
      expect(@board.has_won?(3,3, :X)).to be false
    end

  end

  describe "#column_full?" do

    before(:each) do
      @board = Board.new(7,6)
      @board.contents.each_index do |row|
        @board.contents[row][2] = :Q
      end
    end
    
    it "returns true when column is full" do
      expect(@board.column_full?(2)).to be true
    end

    it "returns false when column is empty" do
      expect(@board.column_full?(4)).to be false
    end

    it "returns false when column is nearly full" do
      @board.contents[0][2] = nil
      expect(@board.column_full?(2)).to be false
    end

  end

  describe "#full?" do 

    before(:each) do
      @board = Board.new(7,6)
    end
    
    it "returns true if all positions of board are filled" do
      @board.contents.map! { [:X,:O,:X, :O, :X, :O, :X] }
      expect(@board.full?).to be true
    end

    it "returns false if nearly all positions of board are filled" do
      @board.contents.map! { [:X,:O,:X, :O, :X, :O, :X] }
      @board.contents[0][0] = nil
      expect(@board.full?).to be false
    end

    it "returns false if board is empty" do
      expect(@board.full?).to be false
    end

  end

  describe "#to_s" do

    before(:each) do 
      @board = Board.new(7,6)
    end

    it "returns appropriate string representation for an empty board" do
      expect(@board.to_s).to eq("|             |\n|             |\n|             |\n|             |\n|             |\n|             |\n")
    end

    it "returns appropriate string representation for partially filled board" do
      @board.contents[5][5] = :O
      @board.contents[5][6] = :O
      @board.contents[5][2] = :X
      @board.contents[4][2] = :X
      expect(@board.to_s).to eq("|             |\n|             |\n|             |\n|             |\n|    X        |\n|    X     O O|\n")
    end

    it "returns appropriate string representation for a full board" do
      @board.contents.map! {|r| [:O, :X, :O, :X, :O, :X, :O]}
      expect(@board.to_s).to eq("|O X O X O X O|\n|O X O X O X O|\n|O X O X O X O|\n|O X O X O X O|\n|O X O X O X O|\n|O X O X O X O|\n")
    end

  end

end