#Queue Class Implementation
class Queue
    def initialize
        @ivar = []
    end

    def enqueue(el)
        @ivar.push(el)
    end

    def dequeue
        @ivar.shift
    end

    def peek
        @ivar.first
    end
end