# Complete the function below.


def solve_minesweeper(puzzle_array) 

  def ajust(puzzle_array)
    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        if item == 'm'
          puzzle_array[i][j] = -1
        else
          puzzle_array[i][j] = 0
        end
      end
    end
    puzzle_array
  end


  def print_puzzle_array(puzzle_array)
    
    puzzle_array.each do |r|
      p r
    end
    puts 
    puts
  end

  ajusted_puzzle_array = ajust(puzzle_array)



  def rule_1(puzzle_array,r,column)
    points = 0
    
    # left                                          
    points += 1 if column - 1 > -1 &&
                   puzzle_array[r][column - 1] == -1 
    # right                                         
    points += 1 if column + 1 < puzzle_array[r].length && 
                   puzzle_array[r][column + 1] == -1 
    # up
    points += 1 if r - 1 > -1 && 
                   puzzle_array[r - 1][column] == -1  
    # down                                           
    points += 1 if r + 1 < puzzle_array.length && 
                   puzzle_array[r + 1][column] == -1 
    # up_left                                          
    points += 1 if column - 1 > -1 && r - 1 > -1 &&  
                   puzzle_array[r - 1][column - 1] == -1
    # down_rigth                                        
    points += 1 if column + 1 < puzzle_array[r].length && r + 1 < puzzle_array.length &&
                   puzzle_array[r + 1][column + 1] == -1 
    # up_rigth
    points += 1 if r - 1 > -1 && column + 1 < puzzle_array[r].length && 
                   puzzle_array[r - 1][column + 1] == -1
    # down_left
    points += 1 if r + 1 < puzzle_array.length && column - 1 > -1 && 
                   puzzle_array[r + 1][column - 1] == -1

    points
  end

  def rule_2(puzzle_array,r,column)
    points = 0

    # up
    points += 1 if r - 1 > -1 && 
                   puzzle_array[r - 1][column] == -1  
    # # up_left                                          
    # points += 1 if column - 1 > -1 && r - 1 > -1 &&  
    #                puzzle_array[r - 1][column - 1] == -1
    # # up_rigth
    # points += 1 if r - 1 > -1 && column + 1 < puzzle_array[r].length &&
    #                puzzle_array[r - 1][column + 1] == -1

    points
  end

  def rule_3(puzzle_array)
    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        # right                                     
        if puzzle_array[i][j] == -1
           puzzle_array[i][j + 1] = 0 if j + 1 < puzzle_array[i].length  
        end           
      end
    end
    puzzle_array
  end

  def rule_4(puzzle_array)
    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        # right                                     
        if puzzle_array[i].include?(-1) && i % 2 != 0 && puzzle_array[i][j] != -1
           puzzle_array[i][j] *= 3
        end           
      end
    end
    puzzle_array
  end

  def rule_5(puzzle_array,r,column)

    result = 0
    mine_conerners = 0
    
   
    # up_left                                          
    mine_conerners += 1 if column - 1 > -1 && r - 1 > -1 &&  
                   puzzle_array[r - 1][column - 1] == -1
    # down_rigth                                        
    mine_conerners += 1 if column + 1 < puzzle_array[r].length && r + 1 < puzzle_array.length &&
                   puzzle_array[r + 1][column + 1] == -1 
    # up_rigth
    mine_conerners += 1 if r - 1 > -1 && column + 1 < puzzle_array[r].length && 
                   puzzle_array[r - 1][column + 1] == -1
    # down_left
    mine_conerners += 1 if r + 1 < puzzle_array.length && column - 1 > -1 && 
                   puzzle_array[r + 1][column - 1] == -1

    result = puzzle_array[r][column] if mine_conerners > 1
    result
  end

  def mine(puzzle_array)
    puts "ajust rule_6"
    print_puzzle_array(puzzle_array)

    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        puzzle_array[i][j] += rule_1(puzzle_array,i,j)
      end
    end
    puts "rule_1"
    print_puzzle_array(puzzle_array)

    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        puzzle_array[i][j] += rule_2(puzzle_array,i,j)
      end
    end
    puts "rule_2"
    print_puzzle_array(puzzle_array)


    puzzle_array = rule_3(puzzle_array)
    puts "rule_3"
    print_puzzle_array(puzzle_array)

    puzzle_array = rule_4(puzzle_array)
    puts "rule_4"
    print_puzzle_array(puzzle_array)

    
    puzzle_array.each_with_index do |r,i|
      r.each_with_index do |item,j|
        puzzle_array[i][j] += rule_5(puzzle_array,i,j)
      end
    end
    puts "rule_5"
    print_puzzle_array(puzzle_array)
    puzzle_array
    
  end

  result = mine(ajusted_puzzle_array)
  

end

puzzle_array = [
  ['.','m','.','.'],
  ['.','.','.','.'],
  ['.','.','.','m'],
  ['m','.','.','.']
]

p solve_minesweeper(puzzle_array)









