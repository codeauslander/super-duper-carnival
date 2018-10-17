# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(a)
  # write your code in Ruby 2.2
  return 0 unless a[0]
  necklaces = create_necklaces(a)
  
  
  size = necklaces.length
  index = 0
  max = necklaces[index].length
  
  while index < size
    if necklaces[index].length > max
      max = necklaces[index].length
    end
    index += 1
  end
  
  return max
end

def organize_necklaces(messy_necklaces, necklace = [], necklaces = [], done = [], index = 0, undone = messy_necklaces)
  p index
  return necklaces if undone.length == 0
  necklace << messy_necklaces[index]

  if done.include? messy_necklaces[index]

    undone.reject {|number| done.include? number}
    index = undone[0]

    return organize_necklaces(messy_necklaces, [], necklaces, done, index, undone)
  end

  if index == messy_necklaces[index]
    done << index
    undone.delete(index)

    index = undone[0]
    return organize_necklaces(messy_necklaces, [], necklaces << necklace, done, index, undone)
  end

  if necklace[-1] == necklace[0] and necklace[1] != nil
    done = done + necklace
    undone.reject {|number| done.include? number}

    index = undone[0]
    return organize_necklaces(messy_necklaces, [], necklaces << necklace, done, index, undone - done)
  end

  return organize_necklaces(messy_necklaces, necklace, necklaces, done, messy_necklaces[index], undone - done)
end

# messy_necklaces = [0]
# messy_necklaces = [0,1,2,3,4,5,6]
# messy_necklaces = [5,4,0,3,1,6,2]
messy_necklaces = [0,4,5,3,1,2,6]
p organize_necklaces(messy_necklaces)