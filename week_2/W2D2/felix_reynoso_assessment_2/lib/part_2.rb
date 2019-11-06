def proper_factors(nbr)
    arr = []
    (1...nbr).each {|digit| arr << digit if is_factor?(nbr, digit) }
    arr
end

def is_factor?(nbr1, nbr2)
    (nbr1 % nbr2) == 0
end

def aliquot_sum(nbr)
    sum = 0
    factors = proper_factors(nbr)
    factors.each { |nbr| sum += nbr }
    sum
end

def perfect_number?(nbr)
    nbr == aliquot_sum(nbr)
end

def ideal_numbers(n)
    i = 2
    times = 0
    ideal = []

    while times <  n
        if i == my_sum(proper_factors(i))
            ideal << i  
            times += 1
        end
        i += 1
    end  

    ideal 
end


def my_sum(arr)
    i = sum = 0

    while i < arr.length
        sum += arr[i] 
        i += 1
    end

    sum 
end