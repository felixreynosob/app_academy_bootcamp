def average(num_1, num_2)
    avg = (num_1 + num_2)
    avg /= 2.0
end


def average_array(arr)
    sum = arr.inject() { |acc, i| acc + i }
    arr_avg = sum.to_f / arr.length
end


def repeat(str, nbr)
    str * nbr
end


def yell(str)
    str.upcase + '!'
end


def alternating_case(str)
    arr = str.split(" ")
    arr.map!.with_index do |word, idx|
        if idx.even?
            word.upcase
        else 
            word.downcase
        end
    end
    arr.join(" ")
end