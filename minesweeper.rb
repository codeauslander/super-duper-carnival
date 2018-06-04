board = [
  ['.','m','.','.'],
  ['.','.','.','.'],
  ['.','.','.','m'],
  ['m','.','.','.']
]

def ajust(board)
  board.each_with_index do |row,index_row|
    row.each_with_index do |cell,index_cell|
      if cell == 'm'
        board[index_row][index_cell] = -1
      else
        board[index_row][index_cell] = 0
      end
    end
  end
  board
end


def mines(board)

  board.each_with_index do |row,index_row|

    row.each_with_index do |cell,index_cell|
      if cell == -1
        board[index_row][index_cell - 1] += 1 if board[index_row][index_cell - 1] != nil 
        board[index_row][index_cell + 1] += 0 if board[index_row][index_cell + 1] != nil 

  
        if index_row + 1 < board.length
          board[index_row + 1][index_cell] += 2 
          board[index_row + 1][index_cell - 1] += 2 if index_cell - 1 > -1
          board[index_row + 1][index_cell + 1] += 2 if index_cell + 1 < row.length 
        end

        if index_row - 1 > -1
          board[index_row - 1][index_cell] += 2  
          board[index_row - 1][index_cell - 1] += 2 if index_cell - 1 > -1
          board[index_row - 1][index_cell + 1] += 2 if index_cell + 1 < row.length 
        end
      end

    end

  end

  board

end



def print_board(board)
  board.each do |row|
    p row
  end
end

ajusted_board = ajust(board)
print_board(ajusted_board)
p "-" * 20
result = mines(ajusted_board)
print_board(result)

