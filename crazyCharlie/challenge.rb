# size = 0
# numbers = [1,3,5]
# size = size + 3
# i = 0
# total = 0
# loop do 
#   total = total + numbers[i]
#    i += 2
#   break if i > size

# end
# print total


numbers = [1,2,3]
size = 3
j = 0
total = 0
while (j < size) do 
  k = j
  while (k < size) do 
    total = total + numbers[k]
    k = k + 1
  end
  j = j + 1
end
print total

