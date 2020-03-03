require_relative 'card.rb'

class Board

    attr_reader :grid
    def initialize
        @grid = Array.new(4) { Array.new(4, "#") }
        populate 
    end

    
    def populate
        cards = get_random_cards
        cards.each do |card|
            2.times {
            pos = get_free_positions
            x, y = pos[rand(pos.length)]
             @grid[x][y] = card.dup
            }
        end
    end


    def get_random_cards
        alphabet = ('A'..'Z').to_a
        already_saved = [] 
        cards = []
        until (cards.length ==  (@grid.length*2))
            letter = Card.new(alphabet[rand(26)])         
            if !already_saved.include?(letter.value)
                cards << letter
                already_saved << letter.value
            end
        end
        cards
    end


    def get_free_positions
        free = []

        @grid.each_with_index do |row, i|
            row.each_with_index do |el, j|
                free << [i,j] if !el.is_a?(Card)#== "#"
            end
        end

        free
    end
    

    def won?
        @grid.flatten.all? { |card| card.face_up == true }
    end


    def reveal(position)
        x, y = position
        card = self.grid[x][y]
        
        if card.face_down
            card.reveal
            return card.value
        end
        nil
    end


    def hide(position)
        x, y = position
        self.grid[x][y].hide
    end
    

    def print_board
        @grid.each_with_index do |row, i|
            row.each_with_index do |el, j|
                print el.value + "  "
            end
            print("\n")
        end
    end

end




if __FILE__ == $PROGRAM_NAME
    board = Board.new
    board.print_board
    board.won?
    # board.render
    # board.render
end
