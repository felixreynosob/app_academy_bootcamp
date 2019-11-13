class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  
  attr_reader :pegs

  def initialize(peg_arr)
    if self.class.valid_pegs?(peg_arr)
      @pegs = peg_arr.map { |char| char.upcase }
    else
      raise_error
    end
  end
  

  def self.valid_pegs?(peg_arr)
    peg_arr.all? { |peg| POSSIBLE_PEGS.has_key?(peg.upcase) }
  end


  def self.random(length)
    peg_arr = []
    keys = POSSIBLE_PEGS.map { |key, val| key }
    length.times { peg_arr << keys[rand(keys.length)]}
    self.new(peg_arr)
  end


  def self.from_string(peg_str)
    self.new(peg_str.split(''))
  end


  def [](position)
    @pegs[position]
  end


  def length
    @pegs.length
  end
  

  def num_exact_matches(code_instance)
    total_matches = 0

    @pegs.each_with_index do |el, idx|
      if el == code_instance.pegs[idx]
        total_matches += 1
      end
    end

    total_matches
  end


  def num_near_matches(code_instance)
    total_near_matches = 0 

    code_instance.pegs.each_with_index do |el, idx|
      if self.pegs.include?(el) &&  el != @pegs[idx]
        total_near_matches += 1
      end
    end

    total_near_matches
  end


  def ==(other_code)
    return false if self.pegs.length != other_code.pegs.length
    
    idx = 0 

    while idx < self.pegs.length
      if self.pegs[idx] != other_code.pegs[idx]
        return false
      end
      idx += 1      
    end

    true
  end

  
end