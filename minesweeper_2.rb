board = [
  ['.','m','.','.'],
  ['.','.','.','.'],
  ['.','.','.','m'],
  ['m','.','.','.']
]

def ajust(board)
  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      if cell == 'm'
        board[index_row][index_column] = -1
      else
        board[index_row][index_column] = 0
      end
    end
  end
  board
end


def print_board(board)
  
  board.each do |row|
    p row
  end
  puts 
  puts
end

ajusted_board = ajust(board)



def rule_1(board,row,column)
  points = 0
  
  # left                                          
  points += 1 if column - 1 > -1 &&
                 board[row][column - 1] == -1 
  # right                                         
  points += 1 if column + 1 < board[row].length && 
                 board[row][column + 1] == -1 
  # up
  points += 1 if row - 1 > -1 && 
                 board[row - 1][column] == -1  
  # down                                           
  points += 1 if row + 1 < board.length && 
                 board[row + 1][column] == -1 
  # up_left                                          
  points += 1 if column - 1 > -1 && row - 1 > -1 &&  
                 board[row - 1][column - 1] == -1
  # down_rigth                                        
  points += 1 if column + 1 < board[row].length && row + 1 < board.length &&
                 board[row + 1][column + 1] == -1 
  # up_rigth
  points += 1 if row - 1 > -1 && column + 1 < board[row].length && 
                 board[row - 1][column + 1] == -1
  # down_left
  points += 1 if row + 1 < board.length && column - 1 > -1 && 
                 board[row + 1][column - 1] == -1

  points
end

def rule_2(board,row,column)
  points = 0

  # up
  points += 1 if row - 1 > -1 && 
                 board[row - 1][column] == -1  
  # # up_left                                          
  # points += 1 if column - 1 > -1 && row - 1 > -1 &&  
  #                board[row - 1][column - 1] == -1
  # # up_rigth
  # points += 1 if row - 1 > -1 && column + 1 < board[row].length &&
  #                board[row - 1][column + 1] == -1

  points
end

def rule_3(board)
  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      # right                                     
      if board[index_row][index_column] == -1
         board[index_row][index_column + 1] = 0 if index_column + 1 < board[index_row].length  
      end           
    end
  end
  board
end

def rule_4(board)
  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      # right                                     
      if board[index_row].include?(-1) && index_row % 2 != 0 && board[index_row][index_column] != -1
         board[index_row][index_column] *= 3
      end           
    end
  end
  board
end

def rule_5(board,row,column)

  result = 0
  mine_conerners = 0
  
 
  # up_left                                          
  mine_conerners += 1 if column - 1 > -1 && row - 1 > -1 &&  
                 board[row - 1][column - 1] == -1
  # down_rigth                                        
  mine_conerners += 1 if column + 1 < board[row].length && row + 1 < board.length &&
                 board[row + 1][column + 1] == -1 
  # up_rigth
  mine_conerners += 1 if row - 1 > -1 && column + 1 < board[row].length && 
                 board[row - 1][column + 1] == -1
  # down_left
  mine_conerners += 1 if row + 1 < board.length && column - 1 > -1 && 
                 board[row + 1][column - 1] == -1

  result = board[row][column] if mine_conerners > 1
  result
end

def mine(board)
  puts "ajust rule_6"
  print_board(board)

  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      board[index_row][index_column] += rule_1(board,index_row,index_column)
    end
  end
  puts "rule_1"
  print_board(board)

  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      board[index_row][index_column] += rule_2(board,index_row,index_column)
    end
  end
  puts "rule_2"
  print_board(board)


  board = rule_3(board)
  puts "rule_3"
  print_board(board)

  board = rule_4(board)
  puts "rule_4"
  print_board(board)

  
  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_column|
      board[index_row][index_column] += rule_5(board,index_row,index_column)
    end
  end
  puts "rule_5"
  print_board(board)
  board
  
end

result = mine(ajusted_board)
print_board(result)






