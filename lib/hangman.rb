require File.expand_path("../random_word", __FILE__)
require File.expand_path("../player", __FILE__)

class Hangman
  def initialize
    @random_word = RandomWord.new
    @bad_guesses_left = 10
    @named_letters = []
    @game_ended = false
    @another_game = true
  end

  def play!
    welcome
    define_rules if print_rules?
    while @another_game == true
      reset_game
      puts "\n\nLet's find a new word for you.\nYour word has #{@random_word.length} letters."
      while @game_ended == false
        game_round
        check_for_dead
      end
      ask_for_another_game
    end
    puts "See you next time!"
  end

  def welcome
    print "Welcome to Hangman!\nWhat is your name? "
    @player = Player.new(gets.chomp)
    puts "Thank you #{@player.name}, let's play some Hangman!"
  end

  def print_rules?
    print "\n\nType 'y' if you want to see the rules "
    gets.chomp.downcase == "y"
  end

  def define_rules
    puts "\n\n" + "*" * 40
    puts "Every round you have 2 options.\n    1) Guess a letter from this word.\n    2) Guess the entire word."
    puts "If your letter isn't in the word you are looking for you get a strike. Same thing guessing the wrong word."
    puts "If you have 10 strikes.. you're DEAD!"
    puts "*" * 40
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
      puts "Sorry, we missed that."
    end
  end

  def deal_with_letter(letter)
    @named_letters << letter
    if @random_word.word.include?(letter)
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

  def ask_for_another_game
    print "Do you want to play another game? (y/n)  "
    @another_game = false if gets.chomp.downcase == "n"
  end

  def reset_game
    @random_word = RandomWord.new
    @bad_guesses_left = 10
    @named_letters = []
    @game_ended = false
  end

end
