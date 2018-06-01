# TECH INTERVIEW PREP CHICAGO GROUP I:

# Exercise Type: Intro to Recursion

# First, watch this video: https://www.youtube.com/watch?v=hQ-EoNn39wk

# Then, complete the following exercises in pairs: But never use a loop!

# Write a recursive function that prints out the word “INCEPTION” 15 times.
# Write a recursive function that prints out all even numbers from 0 to 100.
# Write a recursive function that adds the sum of all numbers from 1 to 1000.
# Write a recursive function that accepts an array of numbers and returns the sum.
# Write a recursive function that accepts a number and returns its factorial. (The factorial of 5, for example, is 5 * 4 * 3 * 2 * 1 = 120.)

# For more info, check out:
# http://vaidehijoshi.github.io/blog/2014/12/14/to-understand-recursion-you-must-first-understand-recursion/
# https://vimeo.com/24716767

def inception(times = 1)
  return times if times > 15
  puts "#{times} - INCEPTION"
  inception(times + 1)
end
inception

def even_to_100(number = 0)
  return number if number > 100
  puts "#{number}" if number % 2 == 0
  even_to_100(number + 1)
end
even_to_100

def sum_to_1000(number = 0,sum = 0)
  return sum if number > 1000
  sum += number
  sum_to_1000(number + 1, sum)
end
puts "sum of 0 to 1000 = #{sum_to_1000} "

def sum_array(array = [], index = 0, sum = 0)
  return sum if index > array.length - 1
  sum += array[index]
  sum_array(array, index + 1, sum)
end
puts "sum of the array = #{sum_array([1,2,3])}"

def factorial_of(number = 5, result = 1)
  return result if number == 0
  result *= number
  factorial_of(number - 1, result)
end
puts "factorial of 5 #{factorial_of}" 

# TECH INTERVIEW PREP CHICAGO GROUP I:

# Exercise Type: Recursion continued

# Further recursion exercises to pair on. If you haven’t completed the ones from last time, perhaps start with those. Those are available below.

# Fibonacci numbers are numbers that follow this pattern: 1, 1, 2, 3, 5, 8, 13, 21, 34, ... that is, each number is the sum of the two immediate numbers that precede it. Write a recursive function that prints out the list of fibonacci numbers up to 987.
# Write a recursive function that reverses a string.
# Write a recursive function that accepts two numbers (a numerator and denominator), and returns the remainder if you divide the numerator by the denominator. The catch: Do not use the modulo operator!
# Write a recursive function that accepts two numbers and calculates one by the power of the other. For example, if the numbers were 2 and 5, it would calculate 25. Do not use any built-in power operations provided by your computer language.

def fibonacci(top = 20, number_1 = 1, number_2 = 1, list = [1,1])
  return list if list.length == top
  aux = number_2
  number_2 = number_1 + number_2
  number_1 = aux
  list << number_2
  return fibonacci(top, number_1, number_2, list)
end
puts "fibonacci --> #{fibonacci(16)}" 

def reverse_string(text = "", reversed = "", index = 0)
  return reversed if reversed.length == text.length
  position = text.length - index - 1
  reversed << text[position]
  reverse_string(text, reversed, index + 1)
end
puts "reverse_string --> #{reverse_string("reverse a string")}" 

def remainder(numerator,denominator)
  return numerator if numerator - denominator < 0
  remainder(numerator - denominator,denominator)
end
puts "the remainder -->  #{remainder(7,5)}" 

def power_number( power, number, result = 1, index = 0)
  return result if index == power
  result *= number
  power_number(power, number, result, index + 1)
end
puts "power_number -->  #{power_number(3,4)}" 

