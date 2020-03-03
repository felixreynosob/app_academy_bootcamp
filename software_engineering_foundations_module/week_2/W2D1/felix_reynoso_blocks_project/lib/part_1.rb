def select_even_nums(arr)
    arr.select(&:even?)
end


def reject_puppies(arr)
    arr.reject { |el| el["age"] <= 2 } 
end


def count_positive_subarrays(bi_array)
    i = 0

    bi_array.count do|row| 
        i += 1 if  0 < row.inject { |acc, el| acc + el}
    end 

    i
end


def aba_translate(str)
    i = 0
    vowels = "aeiouAEIOU"

    while i < str.length
        if vowels.include?(str[i])
            str = str[0..i]+ "b" + str[i] + str[i+1..-1]
            i += 3
            next
        end
        i += 1
    end

    str
end


def aba_array(arr)
    arr.map { |word| aba_translate(word) }
end