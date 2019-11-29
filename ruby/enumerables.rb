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


end


p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten


# def my_flatten(data)
#     return [data] if !data.is_a?(Array)

#     flattnened = []
#     data.each { |el| flattnened += my_flatten(el) } 
#     flattnened
# end


