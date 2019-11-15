

def recursive_factorial(nbr)
    return nbr if nbr == 1
    return nbr * recursive_factorial(nbr - 1)
end


def recursive_from_nbr_to_one(nbr)
    return if nbr == 0 
    
    recursive_from_nbr_to_one(nbr-1)
    puts nbr
end


def fib(nbr)
    return 1 if nbr == 1 || nbr == 2 
    fib(nbr - 1) + fib(nbr - 2)
end

#puts recursive_factorial(5)
#recursive_from_nbr_to_one(10)
puts fib(7)