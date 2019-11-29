class Computer_player

    attr_reader :mark
    attr_accessor :board

    def initialize(mark)
        @mark = mark
        @board
        @winning_move
        @killer_move
    end


    def display(board) # Displays the board in nice formatting
        @board = board

        puts ('')
        print("#{board[0][0]} | #{board[0][1]} | #{board[0][2]} \n")
        puts "----------"
        print("#{board[1][0]} | #{board[1][1]} | #{board[1][2]} \n")
        puts "----------"
        print("#{board[2][0]} | #{board[2][1]} | #{board[2][2]} \n")
        puts ('')
    end


    def get_empty_positions #Returns an array of the empty positions in the @board
        e_positions = []
        @board.grid.each_with_index do |row, i|
            @board.grid.each_with_index do |el, j|
                e_positions << [i, j] if @board.grid[i][j] == '#' 
            end
        end
        e_positions
    end


    def has_winning_move? # Calls get_empty_positions and verifies if there is a winning move for all empty positions
        
        arr = get_empty_positions
        
        arr.each do |position|
            
            x = position[0]
            y = position[1]

            if x == 0 
                if y == 0  #Checks all posibilities for [0, 0]
                    if  (@board.grid[0][1] == @mark && @board.grid[0][2] == @mark ||  #checks horizontally
                        @board.grid[1][0] == @mark && @board.grid[2][0] == @mark  || #checks vertically
                        @board.grid[1][1] == @mark && @board.grid[2][2] == @mark)     #checks diagonally
                        @winning_move = [x, y]
                        return true
                    end
                elsif y == 1 #Checks all posibilities for [0, 1]
                    if  (@board.grid[0][0] == @mark && @board.grid[0][2] == @mark ||  #checks horizontally
                        @board.grid[1][1] == @mark && @board.grid[2][1] == @mark  ) #checks vertically
                        @winning_move = [x, y]
                        return true
                    end
                elsif y == 2 #Checks all posibilities for [0, 2]
                    if  (@board.grid[0][0] == @mark && @board.grid[0][1] == @mark ||  #checks horizontally
                        @board.grid[1][2] == @mark && @board.grid[2][2] == @mark  || #checks vertically
                        @board.grid[2][0] == @mark && @board.grid[1][1] == @mark)     #checks diagonally
                        @winning_move = [x, y]
                        return true
                    end
                end
            
            elsif x == 1
                if y == 0 #checks all posibilities for [1, 0]
                    if  (@board.grid[1][1] == @mark && @board.grid[1][2] == @mark ||  #checks horizontally
                        @board.grid[0][0] == @mark && @board.grid[2][0] == @mark ) #checks vertically
                        @winning_move = [x, y]
                        return true
                    end
                elsif y == 1 #checks all posibilities for [1, 1]
                    if  (@board.grid[1][0] == @mark && @board.grid[1][2] == @mark ||  #checks horizontally
                        @board.grid[0][1] == @mark && @board.grid[2][1] == @mark ||  #checks vertically
                        @board.grid[0][0] == @mark && @board.grid[2][2] == @mark || #checks diagonally
                        @board.grid[0][2] == @mark && @board.grid[2][0] == @mark) #checks diagonally
                        @winning_move = [x, y]
                        return true
                    end
                elsif y == 2 #checks all posibilities for [1, 2]
                    if  (@board.grid[1][0] == @mark && @board.grid[1][1] == @mark ||  #checks horizontally
                        @board.grid[0][2] == @mark && @board.grid[2][2] == @mark ) #checks vertically
                        @winning_move = [x, y]
                        return true
                    end
                end

            elsif x == 2
                if y == 0 #checks all posibilities for [2, 0]
                    if  (@board.grid[2][1] == @mark && @board.grid[2][2] == @mark ||  #checks horizontally
                        @board.grid[0][0] == @mark && @board.grid[1][0] == @mark  || #checks vertically
                        @board.grid[1][1] == @mark && @board.grid[0][2] == @mark)     #checks diagonally
                        @winning_move = [x, y]
                        return true
                    end
                elsif y == 1 #checks all posibilities for [2, 1]
                    if  (@board.grid[2][0] == @mark && @board.grid[2][2] == @mark ||  #checks horizontally
                        @board.grid[0][1] == @mark && @board.grid[1][1] == @mark )    #checks vertically
                        @winning_move = [x, y]
                        return true
                    end

                elsif y == 2 #checks all posibilities for [2, 2]
                    if  (@board.grid[2][0] == @mark && @board.grid[2][1] == @mark ||  #checks horizontally
                        @board.grid[0][2] == @mark && @board.grid[1][2] == @mark ||    #checks vertically
                        @board.grid[0][0] == @mark && @board.grid[1][1] == @mark) 
                        @winning_move = [x, y]
                        return true
                    end
                end
            end
        end
    
        false
    end

    
    def oponent_has_winning_move? # Checks if the oponent is about to win, and if so, returns a move to block him
        
        if self.mark == 'X'
            oponent_mark = 'O'
        elsif self.mark 'O'
            oponent_mark = 'X'
        end
        arr = get_empty_positions
        
        arr.each do |position|
            
            x = position[0]
            y = position[1]

            if x == 0 
                if y == 0  #Checks all posibilities for [0, 0]
                    if  (@board.grid[0][1] == oponent_mark && @board.grid[0][2] == oponent_mark ||  #checks horizontally
                        @board.grid[1][0] == oponent_mark && @board.grid[2][0] == oponent_mark  || #checks vertically
                        @board.grid[1][1] == oponent_mark && @board.grid[2][2] == oponent_mark)     #checks diagonally
                        @killer_move = [x, y]
                        return true
                    end
                elsif y == 1 #Checks all posibilities for [0, 1]
                    if  (@board.grid[0][0] == oponent_mark && @board.grid[0][2] == oponent_mark ||  #checks horizontally
                        @board.grid[1][1] == oponent_mark && @board.grid[2][1] == oponent_mark  ) #checks vertically
                        @killer_move = [x, y]
                        return true
                    end
                elsif y == 2 #Checks all posibilities for [0, 2]
                    if  (@board.grid[0][0] == oponent_mark && @board.grid[0][1] == oponent_mark ||  #checks horizontally
                        @board.grid[1][2] == oponent_mark && @board.grid[2][2] == oponent_mark  || #checks vertically
                        @board.grid[2][0] == oponent_mark && @board.grid[1][1] == oponent_mark)     #checks diagonally
                        @killer_move = [x, y]
                        return true
                    end
                end
            
            elsif x == 1
                if y == 0 #checks all posibilities for [1, 0]
                    if  (@board.grid[1][1] == oponent_mark && @board.grid[1][2] == oponent_mark ||  #checks horizontally
                        @board.grid[0][0] == oponent_mark && @board.grid[2][0] == oponent_mark ) #checks vertically
                        @killer_move = [x, y]
                        return true
                    end
                elsif y == 1 #checks all posibilities for [1, 1]
                    if  (@board.grid[1][0] == oponent_mark && @board.grid[1][2] == oponent_mark ||  #checks horizontally
                        @board.grid[0][1] == oponent_mark && @board.grid[2][1] == oponent_mark ||  #checks vertically
                        @board.grid[0][0] == oponent_mark && @board.grid[2][2] == oponent_mark || #checks diagonally
                        @board.grid[0][2] == oponent_mark && @board.grid[2][0] == oponent_mark) #checks diagonally
                        @killer_move = [x, y]
                        return true
                    end
                elsif y == 2 #checks all posibilities for [1, 2]
                    if  (@board.grid[1][0] == oponent_mark && @board.grid[1][1] == oponent_mark ||  #checks horizontally
                        @board.grid[0][2] == oponent_mark && @board.grid[2][2] == oponent_mark ) #checks vertically
                        @killer_move = [x, y]
                        return true
                    end
                end

            elsif x == 2
                if y == 0 #checks all posibilities for [2, 0]
                    if  (@board.grid[2][1] == oponent_mark && @board.grid[2][2] == oponent_mark ||  #checks horizontally
                        @board.grid[0][0] == oponent_mark && @board.grid[1][0] == oponent_mark  || #checks vertically
                        @board.grid[1][1] == oponent_mark && @board.grid[0][2] == oponent_mark)     #checks diagonally
                        @killer_move = [x, y]
                        return true
                    end
                elsif y == 1 #checks all posibilities for [2, 1]
                    if  (@board.grid[2][0] == oponent_mark && @board.grid[2][2] == oponent_mark ||  #checks horizontally
                        @board.grid[0][1] == oponent_mark && @board.grid[1][1] == oponent_mark )    #checks vertically
                        @killer_move = [x, y]
                        return true
                    end

                elsif y == 2 #checks all posibilities for [2, 2]
                    if  (@board.grid[2][0] == oponent_mark && @board.grid[2][1] == oponent_mark ||  #checks horizontally
                        @board.grid[0][2] == oponent_mark && @board.grid[1][2] == oponent_mark ||    #checks vertically
                        @board.grid[0][0] == oponent_mark && @board.grid[1][1] == oponent_mark) 
                        @killer_move = [x, y]
                        return true
                    end
                end
            end
        end
    
        false
    end

    def get_move(board)  #Checks if there exists a winning move, if so it returns that move. Otherwise it returns a random available position
        @board = board
        return @winning_move if has_winning_move?
        return @killer_move if oponent_has_winning_move?
            
        x=rand(3)
        y=rand(3)
        
        loop do
            if @board.empty?([x, y])
                return [x, y]
            else
                x = rand(3)
                y = rand(3)
            end        
        end
    end

end