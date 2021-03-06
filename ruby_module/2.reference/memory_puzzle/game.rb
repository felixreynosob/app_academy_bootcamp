require_relative 'board.rb'
require_relative 'card.rb'

class Game

    attr_reader :board, :previous_guessed_pos, :guessed_pos

    def initialize
        @board = Board.new
        @grid = @board.grid
        @previous_guessed_pos = nil
        @guessed_pos = nil
    end


    def play
        while over? == false
            render
            make_guess(prompt) 
            system("clear") 
            render
            sleep(2)
            system("clear")
        end
    end


    def render
        output = Array.new(5) { Array.new(5) }
        output[0][0] = "@"
        output[0][1..-1] = (0...output.length-1).to_a
        (0..3).each { |i| output[i+1][0] = i }
        output[1..-1][1..-1] = @grid
        
        (0...output.length).each do |i|
            (0...output.length).each do |j|
                if i > 0 && j > 0
                    card = @grid[i-1][j-1]
                    if card.face_up == true  
                        print card.value + " " 
                    else
                        print " " + " " 
                    end
                else
                    if i == 0 && j == 0
                        print "  "
                    else
                        print output[i][j], " "
                    end
                end             
            end
            print("\n")
        end
    end


    def prompt
        x = gets.chomp.to_i
        y = gets.chomp.to_i
        [x, y]
    end


    def make_guess(position)
        x , y = @guessed_pos = position

        if @previous_guessed_pos == nil
            @grid[x][y].reveal
            @previous_guessed_pos = @guessed_pos
        else @previous_guessed_pos
            i , j = @previous_guessed_pos
            if @grid[i][j] == @grid[x][y]
                @grid[x][y].reveal 
            else
                show_wrong_guess(position)
                @grid[x][y].hide
                @grid[i][j].hide
            end
            @previous_guessed_pos = nil
        end
    end
   

    def show_wrong_guess(position)
        x , y = position
        @grid[x][y].reveal
        system('clear')
        render
        sleep(1)
    end
    
    def over?
        self.board.won?
    end

    
end

puzzle = Game.new
puzzle.play