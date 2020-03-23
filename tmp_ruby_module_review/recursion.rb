def sum_to(n)
    return n if n == 1
    return nil if n < 1
    n + sum_to(n-1)
end

def add_numbers(nums_array)
    if nums_array.length == 1
        return nums_array.first 
    elsif nums_array.empty?
        return nil
    end

    nums_array.first + add_numbers(nums_array[1..-1])
end

def gamma_fnc(n)
    return nil if n == 0
    return n if n == 1
    n -= 1
    n * gamma_fnc(n)
end

def ice_cream_shop(flavors, favorite)
    return false if flavors.empty?
    return true if flavors.first == favorite
    ice_cream_shop(flavors[1..-1], favorite)
end

def reverse(str)
    return "" if str.empty?
    str[-1] + reverse(str[0...-1])
end