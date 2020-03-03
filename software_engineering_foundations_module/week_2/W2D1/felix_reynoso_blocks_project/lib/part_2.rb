def all_words_capitalized?(arr)
    arr.all? { |word| word == word.capitalize }
end


def no_valid_url?(arr)
    arr.none? { |url|   url.include?(".com") ||
                        url.include?(".net") ||
                        url.include?(".io") ||
                        url.include?(".org")
                }
end


def any_passing_students?(arr)
    arr.any? { |student| avg_grade(student) >=  75 }
end


def avg_grade(hash)
    total_grad_sum = hash[:grades].inject { |sum, nbr| nbr + sum }
    return total_grad_sum / hash[:grades].length.to_f
end