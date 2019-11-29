# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
    
    all_pairs = []

    words.each_with_index do |pair_1, i|
        words.each_with_index do |pair_2, j|
                next if j < i

                if pair_1 != pair_2
                    if contain_all_vowels?(pair_1, pair_2)
                        all_pairs << pair_1 + ' ' +  pair_2 
                        break
                    end
                end
        end
    end

    all_pairs
end


def contain_all_vowels?(word_1, word_2)
    vowels = ["a","e","i","o","u"]
    hash_1 = hash_2 = Hash.new()
    word_1.downcase!
    word_2.downcase!

    word_1.each_char { |char| hash_1[char] = nil }
    word_2.each_char { |char| hash_2[char] = nil }
    
    vowels.all? { |vowel| hash_1.has_key?(vowel) || hash_2.has_key?(vowel) }
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    if num < 0
        num *= -1 
    elsif num == 0
        return "0 has infinite number of factors."      
    end

    (2...num).any? { |factor|  num % factor == 0 }
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    bigrams.select { |bigram| str.include?(bigram) }
end


class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        result = {}
        prc ||= Proc.new { |k, v| k == v }

        self.each { |k, v| result[k] = v if prc.call(k, v) }
        result
    end


end


class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        result = []

        self.each_char.with_index do |char_1, i|
            if i != 0 
                self.each_char.with_index do |char_2, j|
                    next if j < i 

                    if result.length == 0 
                        result << char_2
                    else
                        result << result[-1] + char_2
                    end
                end
            end

            result << char_1
        end

        return result.select { |str| str.length == length } if length 
        result 
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num=0)
        alphabet = ('a'..'z').to_a
        
        (0..(self.length - 1)).each do |idx|
            pos = alphabet.index(self[idx])
            self[idx] = alphabet[(pos+num)% 26]
        end

        self
    end

end