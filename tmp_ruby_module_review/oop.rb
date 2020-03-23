class Animal
    attr_reader :species
    
    def initialize(species)
        @species = species
    end
end

class Human < Animal
    attr_reader :name

    def initialize(name)
        super("Homo Sapiens")
        @name = name
    end
end



