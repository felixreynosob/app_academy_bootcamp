def prime?(nbr)
    unless nbr > 1
        if nbr == 1
            raise ArgumentError.new "1 is not a prime."
        elsif nbr == 0
            raise ArgumentError.new "Division by zero is not defined, therefore it is not a prime."
        else
            raise ArgumentError.new "Prime numbers are always positive and only divisible by 1 and themselves."
        end
    end
    (2...nbr).none? { |n| nbr%n == 0 }
end



begin
puts "Please, input a number."
nbr = gets.chomp.to_i

p prime?(nbr)
rescue ArgumentError => e
    puts "Couldn't check if #{nbr} is prime."
    puts "Error message was: " + e.message

retry
end