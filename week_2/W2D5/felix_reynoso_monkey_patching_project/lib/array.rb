# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    
    def span
        if self.length >= 1  && self.all? { |el| el.to_f == el }
            self.max - self.min
        else
            nil
        end
    end


    def average
        if self.length >= 1 && self.all? { |el| el.is_a?(Integer) }
            self.inject { |sum, el| sum += el } / self.length.to_f
        else
            nil
        end
    end


    def median
        sorted = self.sort

        if sorted.length < 1
            return nil 
        elsif sorted.length.odd?
            return sorted[sorted.length / 2]
        else
            idx = ((sorted.length) / 2) - 1
            return sorted[idx..idx+1].average
        end
    end


    def counts
        hash = Hash.new(0)
        self.each { |el| hash[el] += 1}
        hash
    end


    def my_count(any_val)
        if self.include?(any_val)
            self.inject(0) do |count, el| 
                if el == any_val
                    count += 1  
                else
                    count
                end
            end
        else
            return 0
        end
    end


    def my_index(any_val)
        self.each_with_index { |el, idx| return idx if el == any_val }
        nil
    end


    def my_uniq
        unique = []
        self.each { |el| unique << el if !unique.include?(el) }
        unique
    end

    
    def my_transpose
        i = j = 0 
        transposed = Array.new(self.length) { |arr| arr = Array.new(self.length)}

        self.each do |line|
            i = 0
            line.each do |el|
                transposed[i][j] = el
                i += 1
            end
            j += 1
        end
        
        transposed
    end
end