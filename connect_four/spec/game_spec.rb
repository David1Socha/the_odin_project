require_relative '../lib/connect_four'

describe "Game" do

  before(:each) do
    @p1 = HumanPlayer.new("John", :O)
    @p2 = HumanPlayer.new("Doe", :X)
    @game = Game.new(7, 6, @p1, @p2)
  end
  
  describe "#initialize" do

    it "Creates a board object" do
      expect(@game.board).to be_an_instance_of Board
    end

    it "Saves passed players" do
      expect(@game.players).to match_array([@p1, @p2])
    end

  end

  describe "#run_turn" do
    
    it "Gets the move from the player" do
      expect(@p1).to receive(:get_move).and_return(4)
      @game.run_turn(@p1)
    end

    it "Places player symbol in player-specified column" do
      expect(@p2).to receive(:get_move).and_return(4)
      expect(@game.board).to receive(:place_symbol).and_return([5,4])
      @game.run_turn(@p2)
    end

    it "Updates  Player#won? state based on board after new move" do
      @p2.won = false
      expect(@p2).to receive(:get_move).and_return(4)
      expect(@game.board).to receive(:place_symbol).and_return([5,4])
      expect(@game.board).to receive(:has_won?).with(5,4,@p2.symbol).and_return true
      @game.run_turn(@p2)
      expect(@p2.won?).to be true
    end
  end

end