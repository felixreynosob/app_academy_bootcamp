require 'byebug'


def range_recursive(start, ending)
    return [] if ending <= start 
    [start] + range_recursive(start+1, ending)
end


def range_iterative(start, ending)
    return [] if ending <= start
    (start...ending).map { |el| el }
end


def exponentiation_v1(nbr, power)
    return 1 if power == 0
    return nbr if power == 1
    nbr * exponentiation_v1(nbr, power-1)
end


def exponentiation_v2(nbr, power)
    return 1 if power == 0
    return nbr if power == 1
    if power.even?
        exponentiation_v2(nbr, power/2) ** 2
    else
        nbr * (exponentiation_v2(nbr,(power-1)/2) ** 2)
    end
end


class Array

    def deep_dup(sub_arr=self)
        sub_arr.map do |el|
            if !el.is_a?(Array)
                el
            else
               deep_dup(el) 
            end
        end  
    end

end


def n_fibonacci(n) 
    if n < 1
        return nil 
    elsif n == 1 
        return 0 
    elsif n == 2
        return 1 
    end
    n_fibonacci(n-1)  +  n_fibonacci(n-2) 
end


def n_fibonacci_iterative(n)
    arr = [0,1]
    if n == 1
        return 0
    elsif n == 2 
        return 1
    end
    (n-2).times {
         arr << (arr[0] + arr[1])
         arr.shift
    }
    arr.last
end



def bsearch(arr, target, min=0, max=arr.length-1)
    return nil if min > max || max < min

    mid_index = (min+max)/2
    case arr[mid_index] <=> target

    when 0
        mid_index
    when -1
        min = mid_index+1
        bsearch(arr, target, min, max)
    when 1
        max = mid_index - 1
        bsearch(arr, target, min, max)
    end  
end


p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
