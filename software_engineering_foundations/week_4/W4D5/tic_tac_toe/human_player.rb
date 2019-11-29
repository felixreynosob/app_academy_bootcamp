class Human_player 

    attr_reader :board, :mark
    attr_writer :board

    def initialize(mark)
        @mark = mark 
        @board 
    end


    def display(board) # Displays the board in nice formatting
        #@board = board # i think i don't need this

        puts ('')
        print("#{board[0][0]} | #{board[0][1]} | #{board[0][2]} \n")
        puts "----------"
        print("#{board[1][0]} | #{board[1][1]} | #{board[1][2]} \n")
        puts "----------"
        print("#{board[2][0]} | #{board[2][1]} | #{board[2][2]} \n")
        puts ('')
    end


    def get_move(board) # Uses gets to return an array representing the position for the next move
        @board = board
        loop do 
            move = gets.chomp
            move = [move[0].to_i, move[-1].to_i]
            if @board.empty?(move)
                return move 
            else
                puts "That position is taken, try another move!"
            end
        end
    end

end