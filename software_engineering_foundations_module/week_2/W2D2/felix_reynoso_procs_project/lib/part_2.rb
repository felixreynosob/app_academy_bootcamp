def reverser(str, &prc)
    prc.call(str.reverse!)
end


def word_changer(str, &prc)
    arr = str.split(" ")
    new_sentence = []
    arr.each { |word| new_sentence << prc.call(word) }
    new_sentence.join(' ')
end


def greater_proc_value(nbr, prc1, prc2) 
    if prc1.call(nbr) > prc2.call(nbr)
        prc1.call(nbr)
    else 
        prc2.call(nbr)
    end
end


def and_selector(arr, prc1, prc2)
    arr.select { |el| prc1.call(el) && prc2.call(el) }
end


def alternating_mapper(arr, prc1, prc2)
    arr.map.with_index do |el, idx|
        if idx.even?
            prc1.call(el)
        else 
            prc2.call(el)
        end
    end
end