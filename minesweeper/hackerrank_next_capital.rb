def points (a1,a2,a3,b1,b2,b3)
  p [a1,a2,a3]
  p [b1,b2,b3]
  
  result = [0,0]

  result[0] += 1 if a1 > b1
  result[1] += 1 if b1 > a1

  result[0] += 1 if a2 > b2
  result[1] += 1 if b2 > a2

  result[0] += 1 if a3 > b3
  result[1] += 1 if b3 > a3

  result
end 

p points(5,6,7,3,6,10)

