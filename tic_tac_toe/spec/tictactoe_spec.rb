require_relative '../lib/tictactoe'

describe "Grid" do

  describe "#initialize" do

    before(:all) do
      @grid = TicTacToe::Grid.new(3)
    end

    it 'creates a grid with rows of specified size' do
      expect(@grid.contents[0].size).to eq 3
    end

    it 'creates a grid with columns of specified size' do
      expect(@grid.contents.size).to eq 3
    end

    it "fills the grid with numbers representing position" do
      expect(@grid.contents).to eq([[1,2,3],[4,5,6],[7,8,9]])
    end

  end
  
  describe "#full?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when each cell of grid is full (contains a symbol)" do
      @grid.contents.fill [:X,:O, :X]
      expect(@grid.full?).to be true
    end

    it "returns false when some cells are empty (contain non-symbols)" do
      @grid.contents[0][0] = :X
      expect(@grid.full?).to be false
    end

    it "returns false when all cells are empty (contain non-symbols)" do
      expect(@grid.full?).to be false
    end

  end

  describe "#rowcol_to_num" do

    it "returns a single number corresponding to row and column position in the grid" do
      grid = TicTacToe::Grid.new(3)
      expect(grid.rowcol_to_num(1,2)).to eq(6)
    end

  end

  describe "#num_to_rowcol" do
    
    it "returns a row and a column number corresponding to the position represented by the single number on this grid" do
      grid = TicTacToe::Grid.new(4)
      expect(grid.num_to_rowcol(9)).to eq([2,0])
    end

  end

  describe "#can_place_symbol" do

    before(:all) do
      @grid = TicTacToe::Grid.new(2)
      @grid.contents[0][0] = :Y
    end

    it "returns true when position does not contain a symbol" do
      expect(@grid.can_place_symbol?(0,1)).to be true
    end

    it "returns false when position contains a symbol" do
      expect(@grid.can_place_symbol?(0,0)).to be false
    end

  end

  describe "#place_symbol" do

    it "places passed symbol in specified position of grid" do
      grid = TicTacToe::Grid.new(3)
      grid.place_symbol(2,1,:M)
      expect(grid.contents[2][1]).to eq(:M)
    end

  end

  describe "#has_won_horizontal?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when all elements of specified row contain specified symbol" do
      @grid.contents[0] = [:Q, :Q, :Q]
      expect(@grid.has_won_horizontal?(0,:Q)).to be true
    end

    it "returns false when some elements of specified row do not contain specified symbol" do
      @grid.contents[1] = [:X, :Y, :Y]
      expect(@grid.has_won_horizontal?(1,:Y)).to be false
    end

    it "returns false when no elements of specified row contain specified symbol" do
      @grid.contents[2] = [1,2,:A]
      expect(@grid.has_won_horizontal?(2,:B)).to be false
    end

  end

  describe "#has_won_vertical?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when all elements of specified column contain specified symbol" do
      @grid.contents.each {|row| row[1] = :Q}
      expect(@grid.has_won_vertical?(1,:Q)).to be true
    end

    it "returns false when some elements of specified row do not contain specified symbol" do
      @grid.contents[2][2] = :E
      expect(@grid.has_won_vertical?(2,:E)).to be false
    end

    it "returns false when no elements of specified row contain specified symbol" do
      expect(@grid.has_won_vertical?(2,:B)).to be false
    end

  end

  describe "#has_won_diagonal?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when all elements on specified diagonal contain specified symbol" do
      @grid.contents = [[:X,:Y,3],[:Y,:X,:Y],[:X,8,:X]]
      expect(@grid.has_won_diagonal?(2,2,:X)).to be true
    end

    it "returns false when some elements on specified diagonal do not contain specified symbol" do
      @grid.contents = [[:X,:Y,3],[:Y,:X,:Y],[:X,8,:Y]]
      expect(@grid.has_won_diagonal?(1,1,:X)).to be false
    end

    it "returns false when row and column are not along the maximum diagonal of grid" do
      @grid.contents = [[:X,:Y,3],[:Y,:X,:Y],[:X,8,:Y]]
      expect(@grid.has_won_diagonal?(0,1,:Y)).to be false
    end

  end

  describe "#has_won_antidiagonal?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when all elements on specified diagonal contain specified symbol" do
      @grid.contents = [[3,:Y,:X],[:Y,:X,:Y],[:X,8,:X]]
      expect(@grid.has_won_antidiagonal?(0,2,:X)).to be true
    end

    it "returns false when some elements on specified diagonal do not contain specified symbol" do
      @grid.contents = [[:X,:Y,3],[:Y,:X,:Y],[:X,8,:Y]]
      expect(@grid.has_won_antidiagonal?(1,1,:X)).to be false
    end

    it "returns false when row and column are not along the maximum diagonal of grid" do
      @grid.contents = [[:X,:Y,3],[:Y,:X,:Y],[:X,8,:Y]]
      expect(@grid.has_won_antidiagonal?(2,2,:X)).to be false
    end

  end

  describe "#has_won?" do

    before(:each) do
      @grid = TicTacToe::Grid.new(3)
    end

    it "returns true when there is a horizontal victory" do
      @grid.contents[0] = [:Q, :Q, :Q]
      expect(@grid.has_won?(0,0,:Q)).to be true
    end

    it "returns true when there is a vertical victory" do
      @grid.contents.each {|row| row[1] = :W}
      expect(@grid.has_won?(1,1,:W)).to be true
    end

    it "returns true when there is a diagonal victory" do
      @grid.contents[0][0] = :U
      @grid.contents[1][1] = :U
      @grid.contents[2][2] = :U
      expect(@grid.has_won?(0,0, :U)).to be true
    end

    it "returns true when there is an antidiagonal victory" do
      @grid.contents[0][2] = :M
      @grid.contents[1][1] = :M
      @grid.contents[2][0] = :M
      expect(@grid.has_won?(1,1, :M)).to be true
    end

    it "returns false when there is no victory" do
      @grid.contents[0][0] = :X
      expect(@grid.has_won?(0,0, :X)).to be false
    end

  end

end

describe "Player" do
  
  describe "#initialize" do

    it "Creates a new object with specified values" do
      player = TicTacToe::Player.new(:X, "Test Player")
      expect(player.symbol).to eq(:X)
      expect(player.name).to eq("Test Player")
    end

  end
  
end