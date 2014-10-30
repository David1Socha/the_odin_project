def test_player_new(player)
  describe "#new" do

    it "saves passed name" do
      expect(player.name).to eq("Bob")
    end
 
    it "saves passed symbol" do
      expect(player.symbol).to eq(:O)
    end
 
    it "sets won to false" do
      expect(player.won?).to be false
    end
 
  end
end