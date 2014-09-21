require 'yaml'

module Hangman
  WORDS = File.readlines("5desk.txt").map! { |e| e.chomp }
  SAVE_COMMAND = 'save'
  LOAD_COMMAND = 'load'
  SAVE_DIRECTORY = 'savegames'

  class Board

    attr_accessor :guessed_chars
    attr_reader :guesses, :known_chars, :max_guesses

    def initialize(max_guesses, word = WORDS.sample)
      @max_guesses = max_guesses
      @guesses = 0
      @word_chars = word.upcase!.chars.to_a
      @known_chars = Array.new(@word_chars.size, :_)
      @guessed_chars = []
    end

    def to_s
      known_chars_str = @known_chars.join(" ")
      guessed_chars_str = @guessed_chars.join(" ")
      "Current knowledge: #{known_chars_str}. Already guessed: #{guessed_chars_str} #{@guesses}/#{@max_guesses} guesses used."
    end

    def add_guess(guessed_char)
      guessed_char.upcase!
      @guesses += 1 unless @word_chars.include? guessed_char
      @guessed_chars << guessed_char unless (@guessed_chars.include?(guessed_char) || @word_chars.include?(guessed_char))
      @word_chars.each_with_index do |c, i|
        @known_chars[i] = guessed_char if c == guessed_char
      end
    end

    def won?
      return @word_chars == @known_chars
    end

    def lost?
      return !won? && @guesses >= @max_guesses
    end

  end

  class Game

    def initialize(max_guesses = 6)
      @board = Board.new(max_guesses)
    end

    def load_board
      load_file = get_load_file
      board_yaml = load_file.read
      @board = YAML::load board_yaml
      load_file.close
    end

    def play
      until @board.lost? || @board.won? do
        puts @board
        move = get_move
        if move == SAVE_COMMAND
          save_board
        elsif move == LOAD_COMMAND
          load_board
        else
          @board.add_guess(move)
        end
      end
      puts @board.won? ? "You win!" : "You lose :("
    end

    def get_move
      valid_input = false
      until valid_input do
        puts "Guess a letter, enter '#{LOAD_COMMAND}' to load game, or enter '#{SAVE_COMMAND}' to save game"
        move = gets.chomp
        if move.length > 1 && move != SAVE_COMMAND && move != LOAD_COMMAND
          puts "Please enter only one character"
        elsif !move[/[a-zA-Z]+/]
          puts "Please enter a letter"
        else
          valid_input = true
        end
      end
      return move
    end

    def get_load_file
      valid_input = false
      until valid_input do
        filename = prompt_filename
        unless File.exist? filename
          puts "Error: File does not exist"
        else
          save_file = File.new(filename, 'r')
          valid_input = true
        end
      end
      return save_file
    end

    def get_save_file
      valid_input = false
      until valid_input do
        filename = prompt_filename
        unless File.exist? filename
          save_file = File.new(filename, 'w')
          valid_input = true
        else
          puts "Error: File already exists"
        end
      end
      return save_file
    end

    def prompt_filename
      puts "Enter name of save file"
      filename = gets.chomp
      filename = "#{SAVE_DIRECTORY}/#{filename}"
    end

    def save_board
      Dir.mkdir(SAVE_DIRECTORY) unless Dir.exists?(SAVE_DIRECTORY)
      save_file = get_save_file
      board_yaml = YAML::dump(@board)
      save_file.write board_yaml
      save_file.close
    end

  end

end

#run a sample game with default of 6 max mistakes
g = Hangman::Game.new
g.play