require_relative 'player.rb'
require 'byebug'

class Game
    
    attr_reader :dictionary, :players
    attr_writer :dictionary

    def initialize(player_1, player_2)
        @players = [player_1, player_2]
        @fragment = ""
        @dictionary = create_dictionary
        @losses = {player_1=>0, player_2=>0}
    end


    def play_round
        
        loop do
            puts "Fragment: '#{@fragment}'"
            take_turn(current_player)
            next_player!
            break if lost_round == true 
        end
    end


    def current_player
        @players[0]                
    end


    def previous_player
        @players[1]
    end


    def next_player!
        @players[0], @players[1] = @players[1], @players[0]
    end


    def take_turn(player)
        finished_turn = false

        until finished_turn
            guess = player.guess
            if valid_play?(guess)
                finished_turn = true 
            else
                player.alert_invalid_guess
            end
        end
        
        @fragment += guess
        @losses[previous_player] += 1 if @dictionary.has_key?(@fragment)  
    end


    def valid_play?(letter)
        alphabet = ('a'..'z').to_a
        return false if !alphabet.include?(letter.downcase)
        @dictionary.each do |key, val|
            return true if key.include?(@fragment + letter)
        end
        false
    end


    def lost_round
        @dictionary.has_key?(@fragment)
    end


    def record(player)
        ghost_record = ['G','H','O','S','T']
        points = @losses[player]
        if points > 0
            player.record[0...points] = ghost_record[0...points]
        end
    end


    def run
        while @losses.values.max < 5
            display_standings
            play_round
            @fragment = ""
        end
        puts "#{@losses.key(5).name} losses, good luck next time"
    end


    def display_standings
        self.players.each  do |player|
            record(player)
            print player.name + "'s record is: '"
            print player.record
            print "\n"
        end
    end


    def create_dictionary
        file = File.open("../assets/dictionary.txt", "r")
        file = file.read.split("\n")
        dictionary = Hash.new
        file.each { |word| dictionary[word] = true }
        dictionary
    end

end


player_1 = Player.new("felix")
player_2 = Player.new("bot")
ghost = Game.new(player_1, player_2)
ghost.run
