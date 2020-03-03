class Board

    attr_reader :size

    def initialize(width_and_height)
        @grid = Array.new(width_and_height) { Array.new(width_and_height, :N) }
        @size = width_and_height * width_and_height
    end

    
    def [](position_2D)
        x = position_2D[0]
        y = position_2D[1]
        @grid[x][y]
    end

    
    def []=(position_2D, value)
        x = position_2D[0]
        y = position_2D[1]
        @grid[x][y] = value
    end

    
    def num_ships
        count = 0
        @grid.each do |row|
            row.each { |el| count += 1 if el == :S }
        end
        count 
    end


    def attack(position_2D)
        if self.[](position_2D) == :S
            self.[]=(position_2D, :H)
            puts "you sunk my battleship!"
            true
        else
            self.[]=(position_2D, :X)
            false
        end
        
    end


    def place_random_ships
        elements_to_place = self.size / 4

        while elements_to_place > 0 
            x = rand(@grid.length)
            y = rand(@grid.length)
            position_2D = [x, y]
            if @grid[x][y] != :S 
                @grid[x][y] = :S
            else
                next
            end
            elements_to_place -= 1
        end
    end


    def hidden_ships_grid
        hidden = Array.new(@grid.length) { Array.new(@grid.length) }

        @grid.each_with_index do |row, i|
            row.each_with_index do |el, j|
                if el == :S
                    hidden[i][j] = :N 
                else
                    hidden[i][j] = el
                end
            end
        end

        hidden
    end

    
    def self.print_grid(grid_to_print)
        grid_to_print.each do |row|
            row.each_with_index do |el, i| 
                print el.to_s
                print ' ' if i < (row.length - 1)
            end
            print("\n")
        end 
    end

    
    def cheat
        self.class.print_grid(@grid)
    end


    def print
        self.class.print_grid(hidden_ships_grid)
    end

end