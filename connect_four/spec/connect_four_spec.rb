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

end
