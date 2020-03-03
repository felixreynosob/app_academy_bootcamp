# Debug this code to pass rspec! There are 2 mistakes to fix.

# Write a method, many_vowel_words, that accepts a sentence string as an arg. 
# The method should return a new sentence containing only the words that contain two or more vowels.

require "byebug"

def many_vowel_words(sentence)
    words = sentence.split(" ")
    result = []

    new_words = words.each do |word|
        num_vowels = num_vowels(word)
        if num_vowels >= 2
             result << word
        else
            next
        end
    end

    result.join(" ")
end

def num_vowels(word)
    count = 0
    word.each_char do |char|
        count += 1 if "aeiouAEIOU".include?(char)
    end
    count
end