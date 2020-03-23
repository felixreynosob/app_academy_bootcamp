def sqrt(nbr)
    raise ArgumentError.new "Cannot take sqrt of negative number." if nbr < 0
    (2..(nbr/2)).each  { |n| return n if (n * n) == nbr}
    nil
end

def main
    while true
        puts "Please input a number."
        num = gets.to_i

        begin 
            result = sqrt(num)
        rescue ArgumentError => e
            puts "Could not take the square root of #{num}"
            puts "Error was: #{e.message}"
        ensure
            puts "the ensure was called"
        end
        puts result
        sleep(3)
    end
end
