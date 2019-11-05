def my_reject(arr, &prc)
    arr.select { |el| prc.call(el) == false }
end


def my_one?(arr, &prc)
    count = 0
    arr.each { |el| count += 1 if prc.call(el) }
    count == 1
end


def hash_select(hash, &prc)
    new_hash = {}
    hash.each do |k, v| 
        if prc.call(k, v) 
            new_hash[k] = v 
        else
            next
        end
    end
    new_hash
end


def xor_select(arr, prc1, prc2)
    n_arr = []
    arr.each do  |el| 
        if prc1.call(el) && prc2.call(el)
            next
        elsif (prc1.call(el) && prc2.call(el) == false ) && prc1.call(el) || prc2.call(el)
            n_arr << el 
        end
    end
    n_arr
end


def proc_count(val, arr)
    count = 0
    arr.each do |prc|
        count += 1 if prc.call(val)
    end
    count
end