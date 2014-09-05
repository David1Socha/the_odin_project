module Mastermind
  PATTERN_LENGTH = 4
  POSSIBLE_COLORS = %W(B W R Y G O)

  class Pattern
    attr_reader :colors
    
    def initialize(colors)
      @colors = Array.new
      raise ArgumentError, "Incorrect pattern length: should be #{PATTERN_LENGTH} elements" unless colors.length == PATTERN_LENGTH
      colors.each do |c|
        raise ArgumentError, "Invalid color: #{c}" unless POSSIBLE_COLORS.include? c
        @colors << c
      end
    end

    def matches?(pattern)
      return @colors == pattern.colors
    end
  end

  class Player

    attr_accessor :human, :name
    alias_method :human?, :human

    def get_pattern
      raise NotImplementedError
    end

    def get_guess(past_feedback)
      raise NotImplementedError
    end

  end

  class HumanPlayer < Player
    
    def initialize(name="Human Player")
      @name = name
      @human = true
    end

    def get_pattern
      get_colors :pattern 
    end

    def get_colors(input_name)
      valid_input = false
      until valid_input
        begin
          puts "Enter #{input_name} (Length must be #{PATTERN_LENGTH}, colors must be #{POSSIBLE_COLORS}, separate by spaces): "
          pattern_a = gets.chomp.split
          pattern = Pattern.new(pattern_a)
          valid_input = true
        rescue ArgumentError => e
          puts e.message
        rescue NoMethodError
          puts "Please enter something."
        end
      end
      return pattern
    end

    def get_guess(past_feedback)
      puts "Previous Guesses:" unless past_feedback.empty?
      puts past_feedback
      get_colors :guess
    end

  end 

  class RandomAI < Player #generates both patterns and guesses completely randomly

  	def initialize(name="Computer")
  	  @name = name
      @human = false
    end

    def get_pattern
      make_random_pattern
    end

    def make_random_pattern
      colors = Array.new
      PATTERN_LENGTH.times do
        colors << POSSIBLE_COLORS.sample
      end
      pattern = Pattern.new(colors)
    end

    def get_guess(past_feedback)
      make_random_pattern
    end

  end

  class Feedback

    attr_accessor :guess, :white_dots, :black_dots, :correct
    alias_method :correct?, :correct

    def initialize(guess)
      @guess = guess
      @white_dots = 0
      @black_dots = 0
      @correct = false
    end

    def to_s
      "Guess: #{@guess.colors} | White Dots: #{@white_dots} | Black Dots: #{@black_dots}"
    end

  end

  class Game

    attr_reader :max_guesses, :coder, :guesser

    def initialize(max_guesses = 12, coder, guesser)
      @max_guesses = max_guesses
      @coder = coder
      @guesser = guesser
    end

    def check_guess(guess)
      feedback = Feedback.new(guess)
      guessed_freq = Hash.new(0)
      code_freq = Hash.new(0)
      @code.colors.zip(guess.colors).each do |pair|
        guessed_color = pair.last
        code_color = pair.first
        if code_color == guessed_color
          feedback.black_dots += 1
        else
      	  guessed_freq[guessed_color] += 1
      	  code_freq[code_color] += 1
        end
      end
      guessed_freq.each_pair do |key, val|
        feedback.white_dots += [val, code_freq[key]].min
      end
      feedback.correct = true if feedback.black_dots == PATTERN_LENGTH
      return feedback
    end

    def play
      @code = @coder.get_pattern
      past_feedback = Array.new
      last_feedback = nil
      @max_guesses.times do 
        guess = @guesser.get_guess past_feedback
        last_feedback = check_guess guess
        past_feedback << last_feedback
        display_guess last_feedback
        break if last_feedback.correct?
      end
      if last_feedback.correct?
        puts "#{@guesser.name} wins!"
      else
      	puts "#{@coder.name} wins!"
      end
    end

    def display_guess(feedback)
      puts "#{@guesser.name} #{feedback.correct? ? "correctly" : "incorrectly"} guessed that the pattern was #{feedback.guess.colors}."
      puts "Feedback: #{feedback.black_dots} black dots and #{feedback.white_dots} white dots." unless feedback.correct?
      puts
    end

  end

end

#To run a sample game of Mastermind (as guesser)
p1 = Mastermind::RandomAI.new
p2 = Mastermind::HumanPlayer.new("Test Human Person")
game = Mastermind::Game.new(p1, p2)
game.play