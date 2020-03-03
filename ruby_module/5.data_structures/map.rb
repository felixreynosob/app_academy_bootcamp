class Map
    def initialize
        @kmap = []
    end

    
    def set(key, value)
        pair = (@kmap.select { |pair| pair[0] == key })[0] unless @kmap.empty?
        
        if  pair == nil || pair.empty?
            position = nil
        else
            position = @kmap.index(pair)
        end

        if position == nil
            @kmap.push([key, value])
        else 
            @kmap[position][1] = value
        end
    end

    
    def get(key)
        pair = @kmap.select { |pair| pair[0] == key }[0]
        pair[1] unless pair.empty?
    end

    
    def delete(key)
        pair = @kmap.select { |pair| pair[0] == key }[0]
        if pair == nil || pair.empty?
            nil
        else
            val = pair[1]
            @kmap.delete(pair)
            val
        end
    end

    
    def show
        @kmap
    end 
end