def partition(arr, nbr)
    bi_arr = Array.new(2) { Array.new() }

    arr.each do |el|
        if el < nbr
            bi_arr[0] << el
        elsif el >= nbr
            bi_arr[1] << el
        end
    end

    bi_arr
end


def merge(hsh_1, hsh_2)
    merged = {}
    hsh_1.each { |k, v| merged[k] = v } 
    hsh_2.each { |k, v| merged[k] = v }
    merged
end


def censor(sentence, arr)
    vowels = "AEIOUaeiou"
    arr_of_str = sentence.split(" ")

    arr_of_str.map! do |word|
        if arr.include?(word.downcase)
            formatted = (0..word.length - 1).map do |i|
                if vowels.include?(word[i]) 
                    word[i] = '*'
                else
                    word[i]
                end
            end
            formatted.join("")
        else 
            word
        end
    end

    arr_of_str.join(" ")
end


def power_of_two?(nbr)
    (0...nbr).each { |x| return true if (2**x) == nbr }
    false
end