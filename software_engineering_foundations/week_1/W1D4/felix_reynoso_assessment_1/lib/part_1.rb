def is_prime?(nbr)
    return false if nbr < 2
  
    (2...nbr).each do |digit| 
       if (nbr % digit) == 0
         return false 
       end
    end

    return true
end

def nth_prime(idx)
    i = 0
    nbr = 2
    arr = []

    while i < nbr
        arr << nbr if is_prime?(nbr)
        nbr += 1
        return arr[idx-1]if arr.length == idx
    end

end

def prime_range(min, max)
    arr = []

    (min..max).each{|nbr| arr << nbr if is_prime?(nbr)}
    
    return arr
end