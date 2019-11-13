require_relative "code"

class Mastermind

    attr_reader :secret_code


    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code_instance)
        puts "exact matches: #{code_instance.num_exact_matches(@secret_code)}"
        puts "near matches: #{code_instance.num_near_matches(@secret_code)}"  
    end

    def ask_user_for_guess
        #puts 'Enter a code'
        str = gets.chomp
        n_instance = Code.from_string(str)
        print_matches(n_instance)
        
    end

end



# m_obj = Mastermind.new(4)
# p m_obj.secret_code
# p "--"
# p m_obj.print_matches(Code.new(["Y", "B", "G", "R"]))




