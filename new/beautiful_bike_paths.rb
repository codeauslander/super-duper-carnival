# Complete the function below.


def max_florists(path_length, florist_intervals) 
  count = 0
  min = 0
  i = 3
  path = (0..path_length)

  florist_1 = 

  florist_intervals.length.times do 
    min = florist_intervals[i][0]
    max = florist_intervals[i][1]

    florist = (min..max)

  end


end

path_length = 9
florist_intervals = [[1, 10], [1, 6], [2, 8], [3, 5]]

p max_florists(path_length, florist_intervals)