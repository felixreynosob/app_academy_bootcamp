class Flight

    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end


    def full?
        self.passengers.length == @capacity
    end


    def board_passenger(passenger)
        if !self.full?
            if passenger.has_flight?(@flight_number)
                passengers.push(passenger)
            end
        end
    end

    
    def list_passengers
        passengers.map { |passenger| passenger.name }
    end


    def [](index)
        passengers[index]
    end


    def <<(passenger)
        board_passenger(passenger)
    end

end