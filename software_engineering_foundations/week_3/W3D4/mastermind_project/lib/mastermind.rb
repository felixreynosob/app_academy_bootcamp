require_relative "code"

class Mastermind

    def initialize(length)
        @secret_code = Code.random(length)
    end


    def print_matches(code_instance)
        puts "exact matches: #{@secret_code.num_exact_matches(code_instance)}"
        puts "near matches: #{@secret_code.num_near_matches(code_instance)}"

    end


    def ask_user_for_guess
        puts "Enter a code"
        str = gets.chomp
        n_instance = Code.from_string(str)
        print_matches(n_instance)
        i = 0
        while i < @secret_code.length
           return false if @secret_code[i] != n_instance.pegs[i]
           i += 1
        end
        true
    end

end


