require_relative "board"
require_relative "player"

class Battleship

    attr_reader :board, :player

    def initialize(board_dimensions)
        @player = Player.new
        @board = Board.new(board_dimensions)
        @remaining_misses = @board.size / 2
    end


    def start_game
        self.board.place_random_ships
        puts "A total of #{self.board.num_ships} ships have been placed on the board\n\n"
        self.board.print
    end


    def lose?
        if @remaining_misses <= 0 
            puts "you lose"
            true
        else
            false
        end
    end

    
    def win?
        if self.board.num_ships <= 0 
            puts "you win"
            true
        else
            false
        end
    end


    def game_over?
        self.win? || self.lose?
    end


    def turn
        if !self.board.attack(self.player.get_move)
            @remaining_misses -= 1
        end
        self.board.print
        puts "You have '#{@remaining_misses}' more chances" 
    end

end