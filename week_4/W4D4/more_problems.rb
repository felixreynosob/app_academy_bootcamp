def no_dupes?(arr)
    result = []
    (0..(arr.length - 1)).each  do |i|
        if !arr[0...i].include?(arr[i]) && !arr[i+1..-1].include?(arr[i])
            result << arr[i]
        end
    end
    
    result
end


def no_consecutive_repeats?(arr)
    (0...arr.length - 1).all? { |i| arr[i] != arr[i+1] }
end


def char_indices(str)
    indices = {}

    str.each_char.with_index do |char, i|
        indices[char] = [] if !indices.has_key?(char)
        indices[char] += [i]
    end

    indices 
end


def longest_streak(str)
    i = j = 0
    streak = []

    while i < str.length
        while str[i] == str[j] 
            j += 1
        end
        streak << str[i...j]
        i = j
    end

    streak.reverse.max_by(&:length)
end


def is_prime?(nbr)
    (2...nbr).all? { |n| nbr % n != 0 }
end


def bi_prime?(nbr)
    (2...nbr).each_with_index do |num_1, i|
        (2...nbr).each_with_index do |num_2, j|
            next if j < i
            if (num_1 * num_2) == nbr && (is_prime?(num_1) && is_prime?(num_2))
                return true
            end
        end
    end

    false
end


def cipher_char(char, offset)
    alphabet_low = ('a'..'z').to_a 
    alphabet_up = ('A'..'Z').to_a 

    if alphabet_low.include?(char)
        pos = (alphabet_low.index(char) + offset) % 26 
        char = alphabet_low[pos]
    elsif alphabet_up.include?(char)
        pos = (alphabet_up.index(char) + offset) % 26 
        char = alphabet_up[pos]
    end
    
    char
end


def vigenere_cipher(message, keys)
    sequence = []
    i = 0

    until sequence.length == message.length
        i = 0 if i == keys.length 
        sequence << keys[i]
        i += 1
    end

    message.each_char.with_index do |char, i| 
        message[i] = cipher_char(char, sequence[i])
    end
    
    message
end


def get_previous_vowel(str)
    vowels = 'aeiouAEIOU'
    i = str.length - 1
    until vowels.include?(str[i])
        i -= 1
    end
    str[i]
end


def has_vowel?(str)
    vowels = 'aeiouAEIOU'
    str.each_char { |char| return true if vowels.include?(char) }
    false
end


def get_last_vowel(str)
    vowels = 'aeiouAEIOU'
    str.reverse.each_char { |char| return char if vowels.include?(char) }
    nil
end


def vowel_rotate(str)
    j = 0
    arr = []
    vowels = 'aeiouAEIOU'
    
    str.each_char.with_index do |char, i|
        if vowels.include?(char) && (has_vowel?(str[0...i]) == false) 
            arr << get_last_vowel(str)
        elsif vowels.include?(char) && has_vowel?(str[0...i]) 
            arr <<  get_previous_vowel(str[0...i])
        end
    end
    
    (0..str.length - 1).each do |i|
        if vowels.include?(str[i])
            str[i] = arr[j]
            j += 1
        end
    end

    str
end


#Proc Problems

class String

    def select(&prc)
        prc ||= Proc.new {|char|}
        res = ""
        self.each_char { |char| res += char if prc.call(char)}
        res 
    end

    def map!(&prc)
        prc ||= Proc.new {|char|}

        (0...self.length).each do |i|
            self[i] = prc.call(self[i], i)
        end
    end

end


#Recursion Problems

def multiply(a, b)
    if a == 0
        return 0 
    elsif a > 0 && b > 0
        sign = 1
        b += multiply(a-sign, b)
    elsif a < 0 && b < 0
        b = multiply(-a, -b)
    elsif a < 0 || b < 0
        a = -a if a < 0
        b = -b if b < 0
        -(multiply(a, b))
    end
end


def lucas_nbr(nbr)
     return 2 if nbr == 1
     return 1 if nbr == 2
     lucas_nbr(nbr - 1) + lucas_nbr(nbr - 2)
end


def lucas_sequence(n)
    return [] if n == 0 
    sequence = []
    (1..n).each { |nbr| sequence << lucas_nbr(nbr) }    
    sequence
end



def prime_factorization(nbr)
    return [nbr] if is_prime?(nbr)

    p_factors = product_of_primes = []
    (2...nbr).each { |n| p_factors << n if is_prime?(n) && nbr % n == 0 }

    p_factors.each do |factor|
        while nbr % factor  == 0
            nbr /= factor
            product_of_primes << factor
        end
    end
    
    product_of_primes
end