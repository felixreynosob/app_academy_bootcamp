require_relative 'player.rb'
require 'byebug'

class Game
    
    attr_reader :dictionary, :players
    attr_writer :dictionary

    def initialize(*players)
        @players = players
        @losses = {}
        @guessed_words = []
        @fragment = ""
        @dictionary = create_dictionary
        self.players.each { |player| @losses[player.name] = 0 }
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
        @players[-1]
    end


    def next_player!
        @players.push(players[0])
        @players.shift
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
        if @dictionary.has_key?(@fragment)
            if @guessed_words.length == 0 
                @losses[previous_player.name] += 1 
                @guessed_words << @fragment
                return true
            elsif @guessed_words.length > 0 && !@guessed_words.include?(@fragment)
                @losses[previous_player.name] += 1
                @guessed_words << @fragment
                return true
            end
        end
        false
    end


    def record(player)
        ghost_record = ['G','H','O','S','T']
        points = @losses[player.name]
        if points > 0
            player.record[0...points] = ghost_record[0...points]
        end
    end


    def run
        over = false 
        until @players.length == 1
            while @losses.values.max < 5
                display_standings
                play_round
                @fragment = ""
            end
            system('clear')
            sleep(1)
            if @losses.values.max == 5
                player_who_lost = @losses.key(5)
                @losses.tap { |hsh| hsh.delete(player_who_lost) }
                @players.each do |player| 
                    if player.name == player_who_lost
                        @players.delete(player) 
                        break
                    end
                end
            end
        end
        puts "#{self.players[0].name} WINS!!!!"
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


if __FILE__ == $PROGRAM_NAME
    player_1 = Player.new("felix")
    player_2 = Player.new("bot")
    player_3 = Player.new("mariel")
    player_4 = Player.new("tomas")

    ghost = Game.new(player_1, player_2)
    ghost.run
end