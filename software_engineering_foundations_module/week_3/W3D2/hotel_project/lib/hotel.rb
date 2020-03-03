require_relative "room"

class Hotel
  
    def initialize(name, hash_rooms)
        @name = name
        @rooms = {}
        hash_rooms.each { |k, v| @rooms[k] = Room.new(v) }
    end


    def name
        tmp = @name.split(" ")
        tmp.each {|word| word.capitalize! }
        tmp.join(" ")
    end


    def rooms
        @rooms
    end


    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            true
        else
            false
        end
    end


    def check_in(guest, room_name)
        if room_exists?(room_name)
            if @rooms[room_name].add_occupant(guest) == true
                puts 'check in successful'
            else
                puts'sorry, room is full'
            end
        else
            puts 'sorry, room does not exist'
        end
    end


    def has_vacancy?
        if @rooms.any? { | k, v| !@rooms[k].full? }
            true
        else
            false
        end
    end


    def list_rooms
        @rooms.each { |k, v| puts "#{k} #{@rooms[k].available_space}" }
    end

end
