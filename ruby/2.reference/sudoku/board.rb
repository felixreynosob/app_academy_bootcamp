require_relative "tile.rb"

class Board

    attr_reader :board, :tile_conflicts
    attr_writer :current_position, :board

    def initialize(grid) 
        @board = grid
        format(board)
        @tile_conflicts = [[],[],[]]
    end


    def self.from_file(file)
        opened = File.open(file)
        read_file = opened.read
        opened.close
        data = read_file.split("\n")
        grid = Array.new(data.length) {Array.new(data.length)}
       
        (0...grid.length).each do |i|
            (0...grid.length).each do |j|
                grid[i][j] = Tile.new(data[i][j])
            end
        end
        Board.new(grid)
    end


    def update_tile(position, val)
        x , y = position
        tile = board[x][y]

        if !tile.given
            tile = board[x][y]
            tile.value = val
        else
            puts "That tile has been given to us and can't be updated"
        end
    end


    def has_conflicts?(position)
        x, y = position
        val = self.board[x][y].value
        already_in_row?(position, val) 
        already_in_column?(position, val)
        already_in_region?(position, val)
        @tile_conflicts != [[],[],[]] 
    end


    def already_in_row?(position, val)
        x, y = position
        (0...y).each do |col| 
            if self.board[x][col].value == val
                @tile_conflicts[0] << [x, col]
            end
        end
        ((y+1)...self.board.length).each do |col| 
            if self.board[x][col].value == val
                @tile_conflicts[0] << [x, col]
            end
        end

        @tile_conflicts[0].length > 0 #if tile conflicts[0] isn't an empty array, it means it had conflicts on the row.
    end
    

    def already_in_column?(position, val)
        x, y = position
        (0...x).each do |row| 
            if self.board[row][y].value == val
                @tile_conflicts[1] << [row, y]
            end
        end
        ((x+1)...self.board.length).each do |row| 
            if self.board[row][y].value == val
                @tile_conflicts[1] << [row, y]
            end
        end

        @tile_conflicts[1].length > 0
    end


    def already_in_region?(position, val)
        x, y = position
        i, j = get_region_start(position)

        (i...(i+3)).each do |row|
            (j...(j+3)).each do |col|
                next if  x == row && y == col #skips the given position to only evaluate unknown positions for given value
                if self.board[row][col].value == val
                    @tile_conflicts[2] << [row, col]
                end
            end
        end

        @tile_conflicts[2].length > 0
    end


    def get_region_start(position)
        x, y = position

        if ((x >= 0) && (x <= 2)) && ((y>=0) && (y <= 2)) #region 0 
            [0,0]
        elsif ((x >= 0) && (x <= 2)) && ((y>=3) && (y <= 5)) #region 1
            [0,3]
        elsif ((x >= 0) && (x <= 2)) && ((y>=6) && (y <= 8)) #region 2
            [0,6]
        elsif ((x>=3) && (x <= 5)) && ((y>=0) && (y <= 2)) #region 3
            [3,0]
        elsif ((x>=3) && (x <= 5)) && ((y>=3) && (y <= 5)) #region 4
            [3,3]
        elsif ((x>=3) && (x <= 5)) && ((y>=6) && (y <= 8)) #region 5
            [3,6]
        elsif ((x >= 6) && (x <= 8)) && ((y>=0) && (y <= 2)) #region 3
            [6,0]
        elsif ((x >= 6) && (x <= 8)) && ((y>=3) && (y <= 5)) #region 4
            [6,3]
        elsif ((x >= 6) && (x <= 8)) && ((y>=6) && (y <= 8))  #region 5 
            [6,6]
        end
    end


    def highlight_conflicts
        (0...self.board.length).each do |row|
            (0...self.board.length).each do |col|
                has_conflicts?([row, col])
            end
        end
       p @tile_conflicts[0].uniq
    end


    def solved?
        board.each_with_index do |row, i|
            row.each_with_index do |el, j|
                return false if has_conflicts([i, j], el)
            end
        end
        true
    end


    def render
        highlight_conflicts 

        (0...board.length).each do |i|
            puts "\n+---+---+---+---+---+---+---+---+---+".colorize(:yellow) if i == 0
            (0...board.length).each do |j|
                lastCol = ""
                if j == 0 || j == 3 || j == 6 
                    color = :yellow
                else
                    color = :white
                end
                
                lastCol = "|".colorize(:yellow) if j == 8
                    
                if board[i][j].given
                    print "|".colorize(color) + " " + board[i][j].value.colorize(:blue), " " + lastCol
                elsif board[i][j].value == '#'
                    print "|".colorize(color) +"   " + lastCol
                else
                    print "|".colorize(color) + " #{board[i][j].value} " + lastCol
                end

            end
            if i == 2 || i == 5 || i == 8
                puts "\n+---+---+---+---+---+---+---+---+---+".colorize(:yellow)
            else 
                puts "\n+---+---+---+---+---+---+---+---+---+"
            end
        end
    end


    def format(grid)
        (0...grid.length).each do |i|
            (0...grid.length).each do |j|
                grid[i][j].given = true if grid[i][j].value != '#'
            end
        end
    end
    

end


if __FILE__ == $PROGRAM_NAME
    board = Board.from_file("input_files/test_conflicts.txt")
    # board.update_tile([3,3],'F')
    # board.update_tile([8,8],'F')
    # p board.has_conflicts?([0,0],"1")
    puts "\n"
    # p board.board[0][1].value
    board.render
    
end