class Hangman
  
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end
  

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length) {"_"}
    @remaining_incorrect_guesses = 5
    @attempted_chars = []
  end


  def guess_word
    @guess_word
  end


  def attempted_chars
    @attempted_chars
  end
  

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end


  def already_attempted?(char)
    if attempted_chars.include?(char)
      true
    else
      false
    end
  end


  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index { |val, idx| arr << idx if char == val }
    arr
  end


  def fill_indices(char, arr)
    arr.each { |idx|  @guess_word[idx] = char }
  end


  def try_guess(char)

    if already_attempted?(char)
      p 'that has already been attempted'
      has_been_attempted = false
    else
      @attempted_chars << char
      has_been_attempted = true
      @remaining_incorrect_guesses -= 1 if !@secret_word.include?(char)
    end

    fill_indices(char, get_matching_indices(char))

    return has_been_attempted
  end

  
  def ask_user_for_guess
    puts "Enter a char:"
    try_guess(gets.chomp)
  end


  def win?
    if guess_word.join("") == @secret_word
      puts "WIN"
      true
    else
      false
    end
  end


  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      true
    else
      false
    end
  end


  def game_over?
    if lose? || win?
      puts @secret_word
      true
    else
      false
    end
  end

end