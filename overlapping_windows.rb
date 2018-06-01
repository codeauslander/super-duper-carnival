AMOUNT_WINDOWS = 8

SCREEN_WEIGHT = 50
SCREEN_HEIGHT = 50

FIRST_X = 1
FIRST_Y = 6

WINDOW_WEIGHT = 5
WINDOW_HEIGHT = 5

SPACE = "_"

class Window 
  attr_accessor :corners, :avatar
  def initialize(corners,avatar)
    @corners = corners
    @avatar = avatar
  end
  def belong?(x,y)
    if x >= @corners[:top_left][0] && 
       x <= @corners[:botton_right][0] && 
       y <= @corners[:top_left][1] &&
       y >= @corners[:botton_right][1] 
       
       return true     
    end
    false
  end

end

class Screen
  attr_accessor :screen, :windows

  def initialize(weight = SCREEN_WEIGHT, height = SCREEN_HEIGHT ,space = SPACE)
    @screen = empty_screen
    @windows = create_windows
    add_windows
  end

  def empty_screen(weight = SCREEN_WEIGHT, height = SCREEN_HEIGHT ,space = SPACE)
    screen = []
    height.times do |x|
      row = []
      weight.times do |y|
        # row <<"[#{x},#{y}]"
        row << space
      end
      screen << row
    end
    screen
  end

  def create_windows(amount = AMOUNT_WINDOWS, position_x = FIRST_X, position_y = FIRST_Y, weight = WINDOW_WEIGHT, height = WINDOW_HEIGHT)
    windows = []
    amount.times do |index|
     windows << Window.new( { top_left:[position_x, position_y], top_right:[position_x + weight, position_y], botton_left:[position_x, position_y - height], botton_right:[position_x + weight, position_y - height] }, "#{index}" )
     position_x += 3
     position_y += 3
    end
    windows
  end

  def add_window(window)
    @screen.length.times do |x|
      @screen[0].length.times do |y|
        @screen[x][y] = window.avatar if window.belong?(x,y)
      end
    end
  end

  def add_windows
    @windows.each do |window|
      add_window(window)
    end
  end

  def overlapping(window_back, window_front)
    if window_back.corners[:top_left][0] < window_front.corners[:top_left][0] &&
       window_front.corners[:top_left][0] < window_back.corners[:botton_right][0] &&
       window_back.corners[:top_left][1] > window_front.corners[:top_left][1] &&
       window_front.corners[:top_left][1] > window_back.corners[:botton_right][1]
       return { 
                top_left: window_front.corners[:top_left] ,
                botton_right: window_back.corners[:botton_right],
                top_right:  [ window_back.corners[:botton_right][0], window_front.corners[:top_left][1] ],
                botton_left:[ window_front.corners[:top_left][0], window_back.corners[:botton_right][1] ]
              }
    elsif window_back.corners[:botton_left][0] < window_front.corners[:botton_left][0] &&
          window_front.corners[:botton_left][0] < window_back.corners[:top_right][0] &&
          window_back.corners[:top_right][1] > window_front.corners[:botton_left][1] &&
          window_front.corners[:botton_left][1] > window_back.corners[:botton_left][1]
       return { 
                top_right: window_back.corners[:top_right] ,
                botton_left: window_front.corners[:botton_left],
                top_left: [ window_front.corners[:botton_left][0], window_back.corners[:top_right][1] ] ,
                botton_right: [ window_back.corners[:top_right][0], window_front.corners[:botton_left][1] ]
              }
    end
    nil
  end

  def show_hide
    index = 1
    @windows.each do |window|
      overlapping_window = overlapping(window,@windows[index]) 
      add_window(Window.new( overlapping_window, "x" )) if overlapping_window != nil
      index += 1 if index < @windows.length - 1
    end
    return @screen
  end

  def show_visible
    show_hide
    screen = []
    @screen.each do |row|
      row.map!{|element|  element == "x" ? SPACE : element}
      screen << row
    end
    @screen = screen
  end

  def show_one(avatar)
    add_window(@windows[avatar])
    screen = []
    @screen.each do |row|
      row.map!{|element|  element == avatar.to_s ? element : "_"}
      screen << row
    end
    @screen = screen
  end

  def print(screen = @screen)
    screen.each do |row|
      p row.join
    end
    puts 
    puts
  end


end


screen = Screen.new

puts "Windows in the screen"
screen.print

puts "Show the hide parts with x"
screen.print(screen.show_hide)

puts "Show just the visible parts in the screen"
screen.print(screen.show_visible)

puts "Show just one window"
screen.print(screen.show_one(3))







