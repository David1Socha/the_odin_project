require_relative '../lib/connect_four'
require_relative 'player_spec_helper'

describe "HumanPlayer" do

  player = HumanPlayer.new("Bob", :O)

  before(:all) do
    @player = player
  end

  test_player_new(player)

  describe "#get_move" do

    before(:each) do
      @board = Board.new(7,6)
      allow(@player).to receive(:puts)
    end

    it "Displays current board state" do 
      expect(@player).to receive(:puts).with("Current Board:",@board)
      allow(@player).to receive(:gets).and_return("3")
      @player.get_move @board
    end

    it "Prompts the user for input" do
      expect(@player).to receive(:puts)
      allow(@player).to receive(:gets).and_return("5")
      @player.get_move @board
    end

    it "Returns integer form of input if it is valid" do
      expect(@player).to receive(:gets).and_return("2")
      expect(@player.get_move(@board)).to eq(2)
    end

    it "Repeats until input is valid number" do
      expect(@player).to receive(:gets).twice.and_return("asdf","4")
      @player.get_move @board
    end

    it "Repeats if input is too small" do
      expect(@player).to receive(:gets).exactly(3).times.and_return("-1239","-1","0")
      @player.get_move @board
    end

    it "Repeats if input is too large" do
      expect(@player).to receive(:gets).exactly(3).times.and_return("89319","7","6")
      @player.get_move @board
    end

    it "Repeats if specified column is full" do
      @board.contents.map! do |row| 
        row[1] = :R
        row
      end
      expect(@player).to receive(:gets).twice.and_return("1","4")
      @player.get_move @board
    end

  end

end