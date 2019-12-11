require 'colorize'

class Tile

    attr_reader :value, :given, :in_conflict
    attr_writer :value, :given, :in_conflict

    def initialize(value=nil)
        @value = value
        @given = false
        @in_conflict = false
    end


    def to_s
        self.value.colorize(:yellow)
    end
    
    


end