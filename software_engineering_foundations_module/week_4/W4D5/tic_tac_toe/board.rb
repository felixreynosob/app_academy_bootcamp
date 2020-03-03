class Board

    attr_reader :grid, :winner_mark
    attr_writer :grid  #temp accessor for testing, please delete when done
    

    def initialize
        @grid = Array.new(3) { Array.new(3, '#') }
        @winner_mark = ''
    end


    def  place_mark(position, mark)  #✔Place_mark returns true if it is successful or false if the position is taken✔
        x = position[0]
        y = position[1]

        if self.empty?([x, y])
            self.grid[x][y] = mark
            true
        else
            false
        end
    end


    def empty?(position) #✔Takes a pisition array and returns true if it's empty or false if taken✔
        x = position[0]
        y = position[1]
        self.grid[x][y] == '#'
    end


    def player_won?(mark) #✔Takes in a mark and checks for every possible winning move to know if this player won✔#

        (0..2).each do |row|
           return true if self.grid[row].all? { |el| el == mark }
        end

       (0..2).any? do |col| 
        return true if  (@grid[0][col] == mark &&
                        @grid[1][col] == mark && 
                        @grid[2][col] == mark)
        end

        if (@grid[0][0] == mark && 
            @grid[1][1] == mark && 
            @grid[2][2] == mark)
            return true
        end

        if (@grid[0][2] == mark && 
            @grid[1][1] == mark && 
            @grid[2][0] == mark)
            return true
        end

        false
    end


    def winner #Returns The winner's Mark
        @winner_mark
    end


    def board_is_full? #checks if the board if full
        @grid.each do |row|
            row.each { |el| return false if el == '#' }
        end
        true
    end


    def over? #✔Checks if game is over, if so, it sets @winner_mark to the winning player and returns true.✔# 
        if player_won?('O')
            @winner_mark = 'O'
            true
        elsif player_won?('X')
            @winner_mark = 'X'
            true
        elsif board_is_full?
            @winner_mark = 'TIE!'
            true
        else
            false
        end
    end

    def display # This is not supposed to be here
        board = @grid

        puts ('')
        print("#{board[0][0]} | #{board[0][1]} | #{board[0][2]} \n")
        puts "----------"
        print("#{board[1][0]} | #{board[1][1]} | #{board[1][2]} \n")
        puts "----------"
        print("#{board[2][0]} | #{board[2][1]} | #{board[2][2]} \n")
        puts ('')
    end
   
    
end