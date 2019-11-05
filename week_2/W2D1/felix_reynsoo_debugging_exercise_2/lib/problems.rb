# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.


def largest_prime_factor(nbr)
    i = nbr
    
    while (i >= 2)
        if nbr % i == 0 && is_prime?(i)
            return i
        end
        i -= 1
    end

    nil
end


def is_prime?(nbr)
    (2...nbr).each { |n| return false if nbr % n == 0 }
    true
end


def unique_chars?(str)
    hash = Hash.new(0)

    str.each_char {|char| hash[char] += 1 }

    return 1 == hash.values.max 
end


def dupe_indices(arr)
    hash = Hash.new { |h, k| h[k] = [] }

    arr.each_with_index { |el, idx| hash[el].push(idx) }
        
    hash.select {|k, v|  hash[k].length > 1 }
end


def ana_array(arr_1, arr_2)
    hash_1 = Hash.new(0)
    hash_2 = Hash.new(0)

    arr_1.each { |el| hash_1[el] += 1 }
    arr_2.each { |el| hash_2[el] += 1 }

    hash_1 == hash_2
end