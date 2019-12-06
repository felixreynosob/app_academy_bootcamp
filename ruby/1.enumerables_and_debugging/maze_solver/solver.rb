class Solver

    attr_accessor :start, :found_winning_paths

    def initialize(maze)
        @maze = maze
        @start = get_start
        @found_winning_paths = []
    end


    def get_start
        @maze.each_with_index do |row, i|            
            row.each_with_index do |el, j| 
                if el == :S
                    return [i, j]
                end
            end
        end
    end


    def has_available_move?(position, current_path)
        x = position[0]
        y = position[1]
        
        if (x-1) >= 0 
            return true if @maze[x-1][y] == "#" && !current_path.include?([x-1,y])     #UP
        end
        if y+1 < @maze[0].length
            return true if @maze[x][y+1] == "#" && !current_path.include?([x, y+1])     #RIGHT
        end
        if (x+1) < @maze.length
            return true if @maze[x+1][y] == "#"  && !current_path.include?([x+1, y])    #DOWN
        end
        if y-1 >= 0
            return true if @maze[x][y-1] == "#"  && !current_path.include?([x, y-1])    #LEFT
        end
        false
    end


    def get_next_moves(position, current_path)
        moves = [] #array of available positions to play 
        x = position[0]
        y = position[1]
        
        
        if (x-1) >= 0 
            moves << [x-1, y] if @maze[x-1][y] == '#' && !current_path.include?([x-1, y])   #UP
        end
        if y+1 < @maze[0].length
            moves << [x, y+1] if @maze[x][y+1] == '#' && !current_path.include?([x, y+1])   #RIGHT
        end
        if (x+1) < @maze.length
            moves << [x+1, y] if @maze[x+1][y] == '#' && !current_path.include?([x+1, y])   #DOWN
        end
        if y-1 >= 0
            moves << [x, y-1] if @maze[x][y-1] == '#' && !current_path.include?([x, y-1])   #LEFT
        end

        if moves.length > 0
            return moves
        else
            return nil
        end
    end


    def reached_end?(position)
        x = position[0]
        y = position[1]
        
        if (x-1) >= 0 
            return true if @maze[x-1][y] == :E   #UP
        end
        if y+1 < @maze[0].length
            return true if @maze[x][y+1] == :E   #RIGHT
        end
        if (x+1) < @maze.length
            return true if @maze[x+1][y] == :E   #DOWN
        end
        if y-1 >= 0
            return true if @maze[x][y-1] == :E   #LEFT
        end
        false
    end


    def find_winning_paths(start, current_path=[])
        if reached_end?(start)
            current_path << start
            @found_winning_paths << current_path
            return true            
        elsif !has_available_move?(start, current_path) 
            return false
        end

        current_path = current_path.dup
        current_path << start
        
        available_moves = get_next_moves(start, current_path)
       
        available_moves.each do |move|
            find_winning_paths(move, current_path)
        end
    end


    def get_shortest_path
        @found_winning_paths.sort_by!(&:length)
        @found_winning_paths[0]
    end


    def get_all_paths
        @found_winning_paths
    end

end