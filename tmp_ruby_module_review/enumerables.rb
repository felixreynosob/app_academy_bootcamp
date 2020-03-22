class Array 

    def my_each
        i = 0 
        while i < self.length do
            yield (self[i])
             i += 1
        end
    end

    def my_select(&block)
        arr = []
        self.my_each { |el| arr.push(el) if block.call(el) }
        arr
    end

    def my_reject(&block)
        arr = []
        self.my_each { |el| arr.push(el) unless block.call(el) }
        arr
    end

    def my_any?(&block)
        self.my_each { |el| return true if block.call(el) }
        false
    end

    def my_all?(&block)
        self.my_each { |el| return false if !block.call(el) }
        true
    end

    def my_flatten
        return [self] if self.class != Array
        flat = []   
        
        self.my_each do |el|
            if el.is_a?(Array)
                flat += el.my_flatten 
            else
                flat += [el]
            end
        end
        flat
    end

    def my_zip(*args)
        zipped = Array.new

       (0...self.length).each do |i|
            tmp = []
            tmp.push(self[i])
            args.my_each do |arr|
                tmp << arr.shift
            end
            zipped.push(tmp)
        end

        zipped
    end

    def my_rotate(nbr=1)
        arr = self.dup
        opposite = true && nbr *= -1 if nbr < 0

        nbr.times {
            unless opposite 
                arr.push(arr.first)
                arr.shift
            else
                arr.unshift(arr.last)
                arr.pop
            end
        }

        arr
    end

    def my_join(middle="")
        str = ""
        (0...self.length).each {|i| str += (self[i].to_s + middle)}

        if middle.empty?
            str
        else
            str[0...-1]
        end
    end

    def my_reverse
        arr = Array.new
        i = self.length-1

        while i >= 0 do
            arr.push(self[i])
            i -= 1
        end

        arr
    end
end
