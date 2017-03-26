require 'spec_helper'

RSpec.describe Hangman do
  describe "Setup of a new game" do
    context "Basic values are correct" do
      let(:game) { Hangman.new }
      it "Total of bad guesses left is 10"
      it "Named letters array is empty"
      it "Game ended toggle is false"
      it "another game toggle is true"
    end
  end
end
