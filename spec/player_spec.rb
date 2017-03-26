require 'spec_helper'

RSpec.describe Player do
  describe "Creation of a new Player" do
    let(:player) { Player.new(name: "Wouter") }
    it "Name of the player is correct" do
      expect(player.name).to have_value("Wouter")
    end
    it "Player starts with 0 points" do
      expect(player.player_score).to eq(0)
    end
    it "Computer starts with 0 points" do
      expect(player.computer_score).to eq(0)
    end
  end
  describe "Player scored a point" do
    let(:player) { Player.new(name: "Wouter") }
    it "one point gets added" do
      score = player.player_score
      player.player_wins
      expect(player.player_score).to eq(score + 1)
    end
    it "computer doesn't get a point" do
      score = player.computer_score
      player.player_wins
      expect(player.computer_score).to eq(score)
    end
  end
  describe "Computer scored a point" do
    let(:player) { Player.new(name: "Wouter") }
    it "a point gets added to the computers score" do
      score = player.computer_score
      player.computer_wins

      expect(player.computer_score).to eq(score + 1)
    end
    it "player doesn't get point" do
      score = player.player_score
      player.computer_wins

      expect(player.player_score).to eq(score)
    end
  end
end
