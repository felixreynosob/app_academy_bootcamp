class Passenger

    attr_reader :name

    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    
    def has_flight?(flight_nbr)
        if @flight_numbers.include?(flight_nbr.upcase)
            return true
        else
            return false
        end
    end

    
    def add_flight(flight_nbr)
        if !has_flight?(flight_nbr)
            @flight_numbers << flight_nbr.upcase
        end
    end

end