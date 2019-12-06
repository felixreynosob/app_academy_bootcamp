class Array
    
    def my_each(&block)
        i = 0
        while i < self.length
            block.call(self[i])
            i += 1 
        end
        self
    end


    def my_select(&block)
        selected = []
        self.my_each { |num| selected << num if block.call(num) }  
        selected       
    end

    
    def my_reject(&block)
        kept_elements = []
        self.my_each { |num| kept_elements << num if !block.call(num) }  
        kept_elements       
    end


    def my_any?(&block)
        self.my_each { |el| return true if block.call(el) }
        false
    end


    def my_all?(&block)
        self.my_each { |el| return false if !block.call(el) }
        true
    end


    def my_flatten(data=self)
        return [data] if !data.is_a?(Array)

        flattened = []
        data.my_each { |el| flattened += my_flatten(el) }
        flattened
    end


    def my_zip(*data)
        zipped = []
        self.my_each { |el| zipped << [el] }
        
        data.my_each do |sub_arr|
            i = 0
            while i < self.length
                zipped[i] << sub_arr[i]
                i += 1
            end
        end

        zipped
    end


    def my_rotate(times=1)
        rot = self.join("")
        if times < 0
            times *= -1
            times.times { rot = rot[-1] + rot[0...-1] }
        else 
            times.times { rot = rot[1..-1] + rot[0] }
        end
        rot.split("")
    end


    def my_join(separator='')
        joined = String.new
        i = 0
        self.my_each do |el|
            if i == (self.length - 1)
                joined += el.to_s
                break
            end
            joined += (el.to_s + separator)
            i += 1
        end
        joined
    end


    def my_reverse
        i = self.length
        reversed = []
        reversed.push(self[i-=1]) while i > 0 
        reversed
    end

end






