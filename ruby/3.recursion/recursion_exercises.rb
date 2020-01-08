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


def merge(arr_1, arr_2) 
    merged = arr_1 + arr_2
    sorted = false
    
    until sorted
        sorted = true
    
        (0...merged.length-1).each do |j|
            if !(merged[j] < merged[j+1])
                merged[j], merged[j+1] = merged[j+1], merged[j]
                sorted = false
                break
            end
        end
    end

    merged
end


def merge_sort(arr)
    return arr if (arr.empty?) || (arr.length <= 1)
    mid_index = (arr.length-1) / 2
    merge(merge_sort(arr[0..mid_index]), merge_sort(arr[mid_index+1..-1]))
end


def subsets(given_arr)
    return [[]] if given_arr.empty?
    old = subsets(given_arr[0...-1])
    old + old.map { |sub| sub + [given_arr.last] }
end


def find_permutations(arr, nbr=0, idx=0)
    idx = 0 if idx >= (arr.length-1)

    return [] if nbr == (1..arr.size).inject { |acc, el| el * acc }

    if nbr > 0
        arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
        idx += 1
    end

    result = arr + [','] + find_permutations(arr.dup, nbr+1, idx)  #=> recursive step 
end
 

def permutations(arr)
    result = find_permutations(arr)
    perms = []
    i = 0

    while i <  result.size
        if result[i] == ','
            i += 1
            next
        end
        j = i
        
        while j < result.size
            if result[j] == ','
                perms.push(result[i...j])
                i = j-1 
                break
            end
            j += 1
        end
        i += 1
    end

    return perms
end