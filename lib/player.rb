class Player
  attr_reader :name, :player_score, :computer_score

  def initialize(name)
    @name = name
    @player_score = 0
    @computer_score = 0
  end

  def player_wins
    @player_score += 1
    puts "YEAAH     You are right!\nYOU WIN!"
    score
  end

  def computer_wins
    @computer_score += 1
    puts "YOU DIED"
    score
  end

  def score
    puts "The score is now #{self.player_score} for you, against #{self.computer_score} for the computer."
  end
end
