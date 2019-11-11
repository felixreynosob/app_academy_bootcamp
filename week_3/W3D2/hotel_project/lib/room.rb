class Room

    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end


    def capacity
        @capacity
    end


    def occupants
        @occupants
    end


    def full?
        if @occupants.length < @capacity
            false
        else
            true
        end
    end


    def available_space
        @capacity - @occupants.length
    end


    def add_occupant(name)
        if !full?
            @occupants << name
            true
        else
            false
        end
    end

end