class RandomWord
  attr_reader :word, :characters

  WORDS = %w(programming monkeybusiness rubyesque styleguide)

  def initialize
    @word = WORDS.sample
  end

  def positions_for(characters: [])
    puts "You already tried these letters: " + characters.join(' ').upcase
    positions = self.word.split(//).map{|i| "_"}
    for i in 0...positions.length
      for j in 0...characters.length
        positions[i] = characters[j] if self.word[i] == characters[j]
      end
    end
    return positions.join(' ')
  end

  def all_letters?(letters)
    (self.word.split(//) - letters).empty?
  end

  def length
    @word.length
  end

  def save_letters(letter)
    @characters << letter
  end

end
