require_relative '../lib/connect_four'

describe "Game" do
  
  describe "#initialize" do

    before(:each) do
      @p1 = HumanPlayer.new("John", :O)
      @p2 = HumanPlayer.new("Doe", :X)
      @game = Game.new(7, 6, @p1, @p2)
    end

    it "Creates a board object" do
      expect(@game.board).to be_an_instance_of Board
    end

    it "Saves passed players" do
      expect(@game.players).to match_array([@p1, @p2])
    end

  end
end