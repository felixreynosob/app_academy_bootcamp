def palindrome?(str)
    i = 0
    j = str.length - 1

    while i < str.length
        return false if str[i] != str[j]
        i += 1
        j -= 1
    end

    true
end


def substrings(str)
    i = z = 0
    collection = {}

    while i < str.length
        j = i 
        while j < str.length
            if i == j
                collection[z] =  str[j]
            elsif z == 0 
                collection[z] =  str[j]
            else 
                collection[z] = (collection[z - 1] + str[j])
            end
            j += 1
            z += 1
        end
        i += 1
    end
    
    collection.map { |k, el| el }
end


def palindrome_substrings(str)
    result = []
    sub_str = substrings(str)
    
    sub_str.each  do |peace|
        result << peace if palindrome?(peace) && peace.length > 1
        
    end
    result
end