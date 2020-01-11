class PolyTreeNode

    attr_reader :children, :parent, :value

    
    def initialize(given_value)
        @value = given_value
        @parent = nil
        @children = []
    end


    def parent=(new_parent)
        if new_parent == nil 
            @parent = nil
        elsif @parent == nil 
            @parent = new_parent
            if !new_parent.children.include?(self) 
                new_parent.children.push(self) 
            end  
        elsif @parent != nil
            @parent.children.delete(self)
            @parent = new_parent
            @parent.children.push(self)
        end
    end

    def add_child(node)
        node.parent= self
        @children.push(node) unless @children.include?(node)
    end


    def remove_child(node)
        node.parent = nil
        raise error if !@children.include?(node)
        @children.delete(node) 
    end
end