def hipsterfy(word)
    vowels = "AEIOUaeiou"
    arr = word.split("")

    return word if arr.none? { |char| vowels.include?(char) }

    arr.reverse!
    (0..arr.length - 1).each do |i| 
        if vowels.include?(arr[i])
            arr[i] = ""  
            break
        end
    end
    arr.reverse!

    arr.join("")
end


def vowel_counts(str)
    if !str.instance_of?(String)
        raise "argument type must be a string"
    end
    vowels = "AEIOUaeiou"
    hash = Hash.new(0)
    str.each_char { |char| hash[char.downcase] += 1 if vowels.include?(char) }
    hash
end


def caesar_cipher(message, n)
    alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    arr = message.split("")
    arr.map!.with_index do |char, idx|
        if !alphabet.include?(char)
            char
        elsif (alphabet.index(char) + n) > 25 && (char == char.downcase)
            alphabet[(alphabet.index(char) + n) % 26 ]
        elsif (alphabet.index(char) + n) > 52 
            alphabet[(alphabet.index(char) + n + 26) % 52 ]
        else
            alphabet[alphabet.index(char) + n]            
        end   
    end

    arr.join("")
end


p caesar_cipher("1", 1)
#p caesar_cipher("APPLE", 1)
