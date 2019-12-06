require 'benchmark'

class Eight_queens
    
 
    attr_accessor :queens, :board, :solutions

    def initialize(board_size=8)
        @queens = board_size
        @board = Array.new(board_size) { Array.new(board_size, '#') } 
        @solutions = []
    end


    def print_board(board=@board)
        board.each do |row| 
            row.each { |el|  print(el.to_s + "  ") }  
            puts ""
        end
    end


    def print_solution(solution)
        solution.each { |queen| place_queen(queen, @board) }
        print_board
        clear_board
    end


    def clear_board(board=@board)
        (0...board.length).each do |row| 
            board[row].map! { |el|  "#" }
        end
    end


    def place_queen(position, board)
        x, y = position
        board[x][y] = :Q
    end


    def get_solution(board)
        solution = []

        (0...board.length).each do |row|
            (0...board[0].length).each do |col| 
                solution << [row, col] if board[row][col] == :Q
            end
        end
        solution
    end

    def can_place_queen?(position, board)     
        !queens_on_diagonal?(position, board)  && 
        !queens_on_row?(position, board)       &&
        !queens_on_column?(position, board)
    end


    def queens_on_diagonal?(position, board)

        x, y = position
        while x >= 0 && y >= 0                #UP LEFT
            return true if board[x][y] == :Q
            x -= 1; y -= 1
        end

        x, y = position
        while x < board.length && y < board.length          #DOWN RIGHT
            return true if board[x][y] == :Q
            x += 1; y += 1
        end

        x, y = position
        while x >= 0 && y < board.length                #UP RIGHT
            return true if board[x][y] == :Q
            x -= 1; y += 1
        end

        x, y = position
        while x < board.length && y >= 0               #DOWN LEFT
            return true if board[x][y] == :Q
            x += 1; y -= 1
        end

        false
    end


    def queens_on_row?(position, board)
        x, y = position
        if y == board.length - 1
            board[x][0...y].any?(:Q)
        else 
            board[x][0...y].any?(:Q) || board[x][y+1..-1].any?(:Q)
        end
    end


    def queens_on_column?(position, board)
        x, y = position
        column = []
        i = -1
        column << board[i][y] while (i+=1) < @board.length
        column[0...x].any?(:Q) || column[x+1..-1].any?(:Q)
    end


    def solve_eight_queens
        (0...self.board.length).each do |col|
            return @solutions if has_solution?(self.board, [0, col])
            clear_board
        end
    end


    def clear_row(row)
        row.map! { |el| "#"}
    end
    
    
    
    def has_solution?(board, start, placed=0)
        if placed == @queens
            @solutions << get_solution(board)
            return true
        end
        
        x, y = start
        
        (0...board.length).each do |row|
            if row < x
                next 
            elsif row == x
                (y...board.length).each do |col|
                    if can_place_queen?([row, col], board) 
                        place_queen([row, col], board)
                        has_solution?(board.dup ,[row, col], placed+1)
                    end
                end
            else
                (0...board.length).each do |col|
                    if can_place_queen?([row, col], board) 
                        place_queen([row, col], board)
                        clear_row(board[row])  if !has_solution?(board,[row, col], placed+1)
                    end
                end
            end
        end
        
        return false
    end
    
   
end



def foo
    time = Benchmark.measure {
        game = Eight_queens.new(5)
        game.print_board
        puts "\n\n"
        game.solve_eight_queens
        game.solutions.each do |solution| 
            game.print_solution(solution) 
            puts "\n\n"
        end
    }
    puts time.real #or save it to logs
end


foo








