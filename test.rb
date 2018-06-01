screen = [["."]*10]*10
x = 0
10.times do
  y = 0
  10.times do 
    screen[x][y] = "#{x.clone},#{y.clone}".clone
    y += 1
  end
x += 1
end
p screen