def element_count(arr)
    hash = Hash.new(0)
    arr.each {|el| hash[el] += 1}
    return hash
end


def char_replace!(str, hash)
    
    str.each_char.with_index do |char, i|
        if hash.has_key?(char)
            str[i] = hash[char]
        end
    end
    return str
end


def product_inject(arr)
    arr.inject { |acc, nbr| acc *= nbr } 
end