class Player

    attr_accessor :record, :name

    def initialize(player_name)
        @name = player_name
        @record = ["_","_","_","_","_"]
    end


    def guess
        puts "#{self.name} please enter a letter."
        gets.chomp.downcase 
    end
    
   
    def alert_invalid_guess
        puts @name + " that's an invalid guess pal, try again!"
    end

end