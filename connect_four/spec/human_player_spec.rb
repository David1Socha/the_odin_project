require_relative '../lib/connect_four'
require_relative 'player_spec_helper'

describe "HumanPlayer" do

  player = HumanPlayer.new("Bob", :O)

  before(:all) do
    @player = player
  end

  test_player_new(player)

  describe "#get_move" do

    before(:all) do
      @board = Board.new(7,6)
    end

    it "Prompts the user for input" do
      expect(@player).to receive(:puts).once
      expect(@player).to receive(:gets).and_return("5")
      @player.get_move @board
    end

    it "Returns integer form of input if it is valid" do
      allow(@player).to receive(:puts)
      expect(@player).to receive(:gets).and_return("2")
      expect(@player.get_move(@board)).to eq(2)
    end

    it "Repeats until input is valid number" do
      expect(@player).to receive(:gets).twice.and_return("asdf","4")
      @player.get_move @board
    end

  end

end