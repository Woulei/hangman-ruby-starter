require 'spec_helper'

RSpec.describe RandomWord do
  let(:random_word) { RandomWord.new }

  it "generates a random word from the WORDS list" do
    expect(RandomWord::WORDS).to include(random_word.word)
  end

  describe "#positions_for(characters: [])" do
    before do
      allow(random_word).to receive(:word).and_return("homebrew")
    end

    it "returns the character positions for all passed in characters" do
      expect(random_word.positions_for(characters: ["e"])).to eq("_ _ _ e _ _ e _")
    end
  end
  describe "all_letters? works correctly" do
    before do
      allow(random_word).to receive(:word).and_return("homebrew")
    end

    it "Return true is all letters have been guessed" do
      letters = ["h","o","m","e","b","r","w"]
      expect(random_word.all_letters?(letters)).to eq(true)
      expect(random_word.all_letters?(letters)).not_to eq(false)
    end
    it "Return false if some letters have not been guessed" do
      letters = ["h","o","m","e","b","r"]
      expect(random_word.all_letters?(letters)).not_to eq(true)
      expect(random_word.all_letters?(letters)).to eq(false)
    end
  end
end
