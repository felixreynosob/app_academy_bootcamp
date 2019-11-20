require_relative 'board.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'

class Game

    attr_reader :player_1, :player_2
    attr_accessor :board

    def initialize(player_1, player_2)
        @player_1 = player_1
        @player_2 = player_2
        @board = Board.new
    end


    def play
        until over?
            if !over?
                play_turn(self.player_1) 
                #display
            end
            if !over?
                play_turn(self.player_2) if !over?
                display
            end
        end
        
        if @board.winner_mark == 'O' || @board.winner_mark == 'X'
            print "\nThe winner for this match is: #{@board.winner_mark}!!!\n"
        else
            print "\nGame over, this match was a #{@board.winner_mark}\n"
        end
    end


    # def current_player

    # end


    # def switch_players!
    # end


    def play_turn(player)
        move = player.get_move(self.board)
        self.board.place_mark(move, player.mark)
    end


    def over?
        self.board.over?
    end


    def display
        self.board.display
    end

end

human = Human_player.new('O')
computer = Computer_player.new('X')
tic_tac_toe = Game.new(human, computer)
tic_tac_toe.play