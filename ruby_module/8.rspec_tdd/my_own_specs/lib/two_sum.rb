def two_sum(nums, target) 
    hsh = Hash.new
    
    nums.each_with_index do |el, idx|
        hsh[el] = [idx] if !hsh.has_key?(el)
    end
    
    hsh.each do |key, arr|
        nbr = target - key
        return [hsh[key].first, hsh[nbr].first] if hsh.has_key?(nbr)
    end

    nil
end

# p two_sum([2, 7, 11, 15], target = 9)