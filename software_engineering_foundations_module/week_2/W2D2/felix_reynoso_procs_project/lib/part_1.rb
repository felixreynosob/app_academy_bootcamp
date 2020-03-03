
def my_map(arr, &prc)
    map = []
    arr.each { |el| map << prc.call(el) }
    map
end


def my_select(arr, &prc)
    map = []
    arr.each { |el| map << el if prc.call(el) }
    map
end


def my_count(arr, &prc)
    count = 0
    arr.each { |el| count += 1 if prc.call(el) }
    count 
end


def my_any?(arr, &prc)
    arr.each { |el| return true if prc.call(el) }
    false
end


def my_all?(arr, &prc)
    arr.each { |el| return false if !prc.call(el) }
    true
end


def my_none?(arr, &prc)
    arr.each { |el| return false if prc.call(el) }
    true
end