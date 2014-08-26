module TicTacToe

  class Grid

    attr_accessor :contents, :size

    def full? 
      return @contents.all? { |e| e.none? { |f| f.is_a? Numeric } } 
    end

    def initialize(size)
      @size = size
      @contents = Array.new(size) { Array.new(size) }
      @contents.map!.with_index do |row, i|
        row.map!.with_index do |value, j|
          rowcol_to_num(i, j)
        end
      end
    end

    def rowcol_to_num(row, col)
      n = @size * (row) + (col+1)
    end

    def num_to_rowcol(n)
      raise IndexError, "Number not in grid range" if n < 1 || n > @size**2
      row = (n-1) / @size
      col = (n-1) % @size
      return row, col
    end

    def can_place_symbol?(row, col)
      return @contents[row][col] == rowcol_to_num(row, col)
    end

    def place_symbol(row, col, symbol)
      @contents[row][col] = symbol
    end

    def has_won?(row, col, player)
      return has_won_horizontal?(row, player) || has_won_vertical?(col, player) || has_won_diagonal?(row, col, player) || has_won_antidiagonal?(row, col, player)
    end

    def has_won_horizontal?(row, player)
      for j in 0...@size
        return false unless player.symbol == @contents[row][j]
      end
      return true
    end

    def has_won_vertical?(col, player)
      for i in 0...@size
        return false unless player.symbol == @contents[i][col]
      end
      return true
    end    

    def has_won_diagonal?(row, col, player) 
      return false unless row == col
      for i, j in (row-1).downto(0).zip((col-1).downto(0))
        break if i.nil? || j.nil?
        puts 'a'
        return false unless player.symbol == @contents[i][j]
      end
      for i, j in ((row+1)...@size).zip((col+1)...@size)
        break if i.nil? || j.nil?
        puts 'b'
        return false unless player.symbol == @contents[i][j]
      end
      return true
    end

    def has_won_antidiagonal?(row, col, player)
      return false unless row + col == @size - 1
      for i, j in (row-1).downto(0).zip((col+1)...@size)
        break if i.nil? || j.nil?
        puts 'c'
        return false unless player.symbol == @contents[i][j]
      end
      for i, j in ((row+1)...@size).zip((col-1).downto(0))
        break if i.nil? || j.nil?
        puts 'd'
        return false unless player.symbol == @contents[i][j]
      end
      return true
    end

    def to_s
      output = String.new
      @contents.each do |row|
        row.each do |e|
          output+= "#{e} "
        end
        output+= "\n"
      end
      output
    end

  end

  class Player

    attr_accessor :symbol, :name

    def initialize(sym, name)
      @symbol = sym
      @name = name
    end

  end

  class Game

    def initialize(size = 3, players)
      @grid = Grid.new(size)
      @players = players
    end

    def get_move(p)
      valid_input = false
      until valid_input
        begin
          puts "#{p.name}, choose where you would like to move."
          n = Integer(gets.chomp)
          row, col = @grid.num_to_rowcol(n)
          if @grid.can_place_symbol?(row, col)
            valid_input = true
          else
            puts "That position is already filled"
          end
        rescue ArgumentError
          puts "Please enter an integer"
        rescue IndexError
          puts "Number is outside of grid range."
        end
      end
      return row, col
    end

    def play
      loop do
        @players.each do |p|
          puts @grid
          row, col = get_move p
          @grid.place_symbol(row, col, p.symbol)
          if @grid.has_won?(row, col, p)
            display_victory p
            return
          elsif @grid.full?
            display_tie
            return
          end
        end
      end
    end

    def display_tie 
      puts "Tie game. Nobody wins"
    end

    def display_victory(winning_player)
      puts "#{winning_player.name} wins!"
    end

  end

end

#To run a sample 3x3 game of TicTacToe
p1 = TicTacToe::Player.new(:X, "Player 1")
p2 = TicTacToe::Player.new(:O, "Player 2")
players = [p1, p2]
game = TicTacToe::Game.new(players)
game.play