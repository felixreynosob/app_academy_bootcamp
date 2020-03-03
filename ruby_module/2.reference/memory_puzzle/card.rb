class Card
    
    attr_reader :face_up, :face_down, :value

    def initialize(letter)
        @face_up = false
        @face_down = true
        @value = letter
    end


    def reveal
        @face_up = true
        @face_down = false
    end
    

    def hide
        @face_up = false
        @face_down = true
    end


    def to_s
        self.value
    end


    def ==(card)
        self.value == card.value
    end

end

if __FILE__ == $PROGRAM_NAME
    p card = Card.new("L")
    card
    p card_b = Card.new("O")
    p card==card_b
end