# Exercise: Bonus Exercise #4

# Build a tic-tac-toe game on the command line where two human players can play against each other and the board is displayed in between turns.

# Try using classes to structure your code. What are the different classes needed here? What are the instance variables? What are the instance methods?

class Player 
  
  def initialize(name)
    @name = name
  end 
  
  def get_name
    return @name 
  end 
  
  def set_name=(name)
    @name = name
  end 
  
end 

class Board 
  
  
  def initialize(rows, columns, empty_symbol, line_symbol)
    
    @empty_symbol = empty_symbol
    @board =initialize_board(rows, columns, empty_symbol)
    @line_symbol = line_symbol
    
  end 
  
  def initialize_board(rows, columns, empty_symbol)
    
    board = []
    
    rows.times do 
      row = []
      columns.times do 
        
        row << empty_symbol
      end 
      
      board << row
      
      
    end 
   
    return board

  end 
  
  def get_board
    return @board
  end 
  
  def set_board= (board)
    @board = board
  end 
  
  def print_board
    
   
    rows = (@board.length * 2) + 1
    columns = (@board[0].length * 2) + 1
    
   
    board_lines = []
    
    rows.times do 
      board_lines_row = []
      columns.times do
        board_lines_row << @line_symbol
      end 
      board_lines << board_lines_row
    end

    index_row = 0
    row_board = 0
    
    rows.times do 
      
      index_column = 0
      column_board = 0
      columns.times do
        
        if !(index_row % 2 == 0) && !(index_column % 2 == 0)
          
          board_lines[index_row][index_column] = " #{@board[row_board][column_board]}"
          !(index_column % 2 == 0) ? column_board += 1 : column_board = column_board
        end 
        
        index_column += 1
      end 
      
      !(index_row % 2 == 0) ? row_board += 1 : row_board = row_board
      index_row += 1
    end 
    
    count = 1
    index_row = 0
    
    board_lines.length.times do 
      index_column = 0
      board_lines[0].length.times do 
        if board_lines[index_row][index_column] == " #{@empty_symbol}"
          # p count
          board_lines[index_row][index_column] = " #{count}"
          
        end 
        
        if board_lines[index_row][index_column] != @line_symbol 
          count += 1 
        end 
        index_column += 1
      end 
       index_row += 1
    end 
    
    board_lines.each do |row|
      puts row.join("")
    end
  end 
  
end

class Interface_Game_Tic_Tac_Toe
  
  def initialize
    
    
    puts "Welcome to Tic Tac Toe."+"\n"+
         "Please set up the game"+"\n"+
         "Enter the number of players"+"\n"
         
    number_of_players = gets.chomp.to_i
    
    @player_names = []
    puts "Please enter #{number_of_players} names one for each player"
    number_of_players.times do 
      
      name = gets.chomp
      @player_names << name
      p name
    end 
    
    puts "Good Job. Now Let's created the board"+"\n"+
         "Please enter the number of rows You want"+"\n"
    
    
    @rows = gets.chomp.to_i 
    
    puts "Now enter the number of columns You want"+"\n"
    
    @columns = gets.chomp.to_i
    
    puts "Finally enter the character You want for the lines of the board (I recomend '.') "
    
    @symbol = " #{gets.chomp}"
    
    puts "Let's play"
    
  end 
  
  def get_player_names
    return @player_names
  end 
  
  def get_rows 
    return @rows 
  end 
  
  def get_columns
    return @columns 
  end 
  
  def get_symbol
    return @symbol
  end 
  
  
end

class Game_Tic_Tac_Toe
  
  LINE_SIZE_WIN = 3
  EMPTY_SYMBOL = "_"
  
  def initialize
    interface = Interface_Game_Tic_Tac_Toe.new
    
  
    @board = Board.new(interface.get_rows, interface.get_columns, EMPTY_SYMBOL, interface.get_symbol)
    
    # @board = Board.new(3, 3, EMPTY_SYMBOL, " .")
    
    @board.print_board
    
    inner_board = @board.get_board
    
    
    @last_position = (inner_board.length * (inner_board.length - 1)) + (inner_board[0].length - 1)
    
    players_names = interface.get_player_names
    # players_names = ["x","o"]
    @players = initialize_players(players_names)
    
    @not_finished = true 
    while @not_finished do 
      @players.each do |player|
      
      if win?(player,@board.get_board)
        command("win", player)
        @not_finished = false
        break
      end 
      
      
      puts "Your turn player #{player.get_name} enter a number between 1 and #{@last_position + 1}"
      input = gets.chomp
      
      
      if input == "board"
        @board.print_board
      end 

      if input == "exit"
        @not_finished  = false
      end
      
      

      if valid_column(input) != -1
         position = valid_column(input)
         board = play(position, player, @board.get_board)
        # p board
         @board.set_board = board
         
         @board.print_board
         
        if win?(player,@board.get_board)
          command("win",player)
          break
        end 
      end 
      
      command(input,player)

     end 
    end 
  end 
  
  def initialize_players(player_names)
    players = []
    player_names.each do |player_name|
      
      players << Player.new(player_name)
    end 
    return players
  end 
  
  
   def win?(player,board)
  
    if win_at_rows?(board, player)
      return true 
    end 
    
    if win_at_columns?(board, player)
      return true
    end 
    
    if win_at_diagonals(board, player)
      return true 
    end 
    
    return false
  end 
  
  def win_at_rows?(board, player)
    
    board.each do |row|
      
      index = 0
      count = 0
      row.length.times do
  
        if row[index] == player.get_name
          count += 1 
        else 
          count = 0 
        end 
    
        if count == LINE_SIZE_WIN
          return true
        end 
    
        index += 1
      end 
    end 
    
    return false
  end 
  
  def win_at_columns?(board, player)
  
    index_column = 0
    board[0].length.times do
      
      index_row = 0 
      count = 0
      board.length.times do
        
        if board[index_row][index_column] == player.get_name
          count += 1
        else 
          count = 0 
        end 
    
        if count == LINE_SIZE_WIN 
          return true
        end 
    
        index_row += 1
      end 
      
      index_column += 1
    end 
  
    return false
  end 
  
  def win_at_diagonals(board, player)
    
    index_row = 0 
    board.length.times do 
      
      index_column = 0
      board[0].length.times do 
        
        if diagonal_win?(index_row, index_column, board, player.get_name)
          return true
        end
        index_column += 1 
      end 
      
      index_row += 1 
    end  
    
    return false 
  end 
  
  def diagonal_win?(index_row, index_column, board, player_name)
    count = 1
    length = LINE_SIZE_WIN - 1
    
    result_1 = 0
    result_2 = 0
    
    if board[index_row][index_column]  == player_name
      
      length.times do 
        
        row = index_row - count
        column = index_column + count
        
        row_2 = index_row + count
        
        if row  < 0 || row > board.length - 1
          row = index_row
        end 
        
        if column < 0 || column > board[0].length - 1
          column = index_column
        end 
        
        if row_2 < 0 || row_2 > board.length - 1
          row_2 = index_row
        end 
        
        if board[row][column]  == player_name
          result_1 += 1
        end 
        
        if board[row_2][column] == player_name
          result_2 += 1 
        end 
        
        count += 1
      end 
      
      result_1 += 1 
      result_2 += 1
      
      if result_1 == LINE_SIZE_WIN || result_2 == LINE_SIZE_WIN
        return true
      end 
      
    end 
    
    return false
  end 
  
  def valid_column(column)
    
    number = column.to_i
    if number > 0 && number < @last_position
      return number
    end 
   
   return -1
  end 
  
  def play(position,player,board) 
    position = position - 1
    index_row = 0 
    played = false
    
    board.length.times do 
      index_column = 0
      board[0].length.times do 
        
        value = board[index_row][index_column]
       
        index_position = (board.length * index_row) + index_column
        
        
        # puts "#{index_position} = (#{board.length} * #{index_row}) + #{index_column}"
        
        if value == EMPTY_SYMBOL && position == index_position
          board[index_row ][index_column] = player.get_name
          played = true 
        end 
      
        index_column += 1
      end 
      
      index_row += 1
    end 
    
    return board
  end 
  
  def command(input, player)
    case input
    when "star"
      result = "Welcome to tic-tac-toe. Please enter a command."
    when "exit"
      result = "Goodbye, thank You for playing, see You later."
    when "board"
      result = "Here is the board, Please enter a column, player #{player.get_name}."
    when "win"
      result = "Youn win!!! Congratulations player #{player.get_name}."
    else 
      result = "Please enter a valid command."
    end 
    
    if valid_column(input) != -1
      result = "Next turn"
    end 
    
    puts result
  end 
  
  
end



game = Game_Tic_Tac_Toe.new