require File.expand_path("../random_word", __FILE__)
require File.expand_path("../player", __FILE__)

class Hangman
  def initialize
    @random_word = RandomWord.new
    @bad_guesses_left = 3
    @named_letters = ["a","b"]
    @game_ended = false
    @another_game = true
  end

  def play!
    welcome
    print "Type 'y' if you want to see the rules "
    define_rules if gets.chomp.downcase == "y"
    while @another_game == true
      reset_game
      @bad_guesses_left = 3
      while @game_ended == false
        puts "Let's find a new word for you."
        game_round
        check_for_dead
      end
      print "Do you want to play another game? (y/n)  "
      if gets.chomp.downcase == "n"
        @another_game = false
      end
    end
    puts "See you next time!"
  end

  def welcome
    print "Welcome to Hangman!\nWhat is your name? "
    name = gets.chomp
    @player = Player.new(name)
    puts "Thank you #{@player.name}, let's play some Hangman!"
  end

  def define_rules
    puts "\n\nEvery round you have 2 options.\n    1) Guess a letter from this word.\n    2) Guess the entire word."
    puts "If your letter isn't in the word you are looking for you get a strike. Same thing guessing the wrong word."
    puts "If you have 10 strikes.. you're DEAD!"
  end

  def print_word
    puts "\n\nOkay #{@player.name}, the word that you need to guess has #{@random_word.length} letters."
    puts "You have #{@bad_guesses_left} bad guesses left before you die."
  end

  def game_round
    puts "#{@random_word.positions_for(characters: @named_letters)}"
    print "What letter or word are you thinking about? "
    answer = gets.chomp.downcase
    if answer.length == 1
      deal_with_letter(answer)
    elsif answer.length > 1
      deal_with_word(answer)
    else
      puts "Sorry, missed that."
    end
  end

  def deal_with_letter(letter)
    @named_letters << letter
    if @random_word.word.include? letter
      puts "Well done!"
      if @random_word.all_letters?(@named_letters)
        @game_ended = true
        @player.player_wins
      end
    else
      @bad_guesses_left -= 1
      puts "Sorry, that letter is wrong. You have #{@bad_guesses_left} bad guesses left."
    end
  end

  def deal_with_word(word)
    if word == @random_word.word
      @game_ended = true
      @player.player_wins
    else
      @bad_guesses_left -= 1
      puts "Sorry that is wrong. You have #{@bad_guesses_left} bad guesses left."
    end
  end

  def check_for_dead
    if @bad_guesses_left == 0
      @game_ended = true
      @player.computer_wins
    end
  end

  def reset_game
    @random_word = RandomWord.new
    @bad_guesses_left = 3
    @named_letters = []
    @game_ended = false
  end

  def print_score
    puts " You have #{@player.player_wins} points and the computer has #{@player.player_score}"
  end

end
