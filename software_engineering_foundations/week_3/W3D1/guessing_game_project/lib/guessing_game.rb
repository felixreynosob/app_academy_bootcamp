class GuessingGame
    def initialize(min, max)
        @secret_num = rand(min..max)
        @num_attempts = 0 
        @game_over = false
    end

    def game_over?
        @game_over
    end
    
    def num_attempts
        @num_attempts
    end

    def check_num(num)
        if num == @secret_num
            @game_over = true
            puts "You win"
        elsif num < @secret_num
            puts "Too small"
        else
            puts "Too big"
        end
        @num_attempts += 1
    end

    def ask_user
        print "Enter a number:"
        check_num(gets.chomp.to_i)
    end  
end
