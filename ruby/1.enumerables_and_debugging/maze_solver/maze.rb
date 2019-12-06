require 'colorize'
require_relative 'solver.rb'

class Maze

    attr_reader :maze, :shortest_path, :all_paths

    def initialize
        @maze = Array.new(5) { Array.new(6, "#") }
        @shortest_path
        @all_paths
    end


    def print_maze(maze=@maze,show_solution=nil)
        if !show_solution
            maze.each do |row|
                row.each { |el| print el.to_s + "  " }
                print ("\n")
            end
        else
            @shortest_path.each do |pos|
                maze[pos[0]][pos[1]]  = 'M'.red
            end
            maze.each do |row|
                row.each { |el| print el.to_s + "  " }
                print ("\n")
            end
            

        end
    end


    def populate_maze
        @maze[1][1] = 'X'
        @maze[2][1] = 'X'
        @maze[3][1] = 'X'
        @maze[3][3] = 'X'
        @maze[2][3] = 'X'
        @maze[1][3] = 'X'
        @maze[1][4] = 'X'
        @maze[3][5] = 'X'
        @maze[4][5] = 'X'
        @maze[4][0] = :S
        @maze[2][5] = :E
    end


    def solve
        solver = Solver.new(self.maze)
        solver.find_winning_paths(solver.start)
        @shortest_path = solver.get_shortest_path
        @all_paths = solver.get_all_paths
    end


    def run
        self.populate_maze
        self.solve
        print_maze
        sleep(5)
        system("clear"); puts "Solution:\n\n"
        show_shortest_path 
    end


    def show_shortest_path 
       copy = @maze.dup
       @shortest_path.each { |pos| copy[pos[0]][pos[1]] = 'M' }
       print_maze(copy,true)
    end

end


if __FILE__ == $PROGRAM_NAME
    maze = Maze.new
    maze.run
end

