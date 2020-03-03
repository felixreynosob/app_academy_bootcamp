# Exercise 1 - sum_to
# Write a function sum_to(n) that uses recursion to calculate the sum 
# from 1 to n (inclusive of n).
def sum_to(n)
    return nil if n < 1
    return n if n == 1
    n + sum_to(n-1)
end


# Exercise 2 - add_numbers
# Write a function add_numbers(nums_array) that takes in an array of 
# Integers and returns the sum of those numbers. Write this method recursively.
def add_numbers(arr)
    return nil if arr.empty?
    return arr.first if arr.length == 1
    arr.first + add_numbers(arr.drop(1))
end


# Exercise 3 - Gamma Function
# Let's write a method that will solve Gamma Function recursively. 
# The Gamma Function is defined Γ(n) = (n-1)!.
def gamma_fnc(num)
    return nil if num < 1
    return 1 if num == 1
    (num - 1) * gamma_fnc(num - 1)
end


# Exercise 4 - Ice Cream Shop
# Write a function ice_cream_shop(flavors, favorite) that takes in an
# array of ice cream flavors available at the ice cream shop, as well 
# as the user's favorite ice cream flavor. Recursively find out whether 
# or not the shop offers their favorite flavor.
def ice_cream_shop(flavors, favorite)
    return false if flavors.empty?
    return true if flavors.first == favorite 
    ice_cream_shop(flavors.drop(1), favorite)
end


# Exercise 5 - Reverse
# Write a function reverse(string) that takes in a string and returns it reversed.
def reverse(str)
    return str if str.length <= 1 
    str[-1] + reverse(str[0...-1])
end