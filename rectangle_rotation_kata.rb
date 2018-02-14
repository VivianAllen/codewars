def rectangulate(a,b)
  af = a.to_f
  bf = b.to_f
  [
    [af / 2, bf / 2],
    [-af / 2, bf / 2],
    [-af / 2, -bf / 2],
    [af / 2, -bf / 2]
  ]
end

def rotate(coords, angle)
  theta = angle * Math::PI / 180
  coords.map do |row|
    x = row[0] * Math.cos(theta) - row[1] * Math.sin(theta)
    y = row[0] * Math.sin(theta) + row[1] * Math.cos(theta)
    [x, y]
  end
end

def ybounds(coords)
  [coords.transpose[1].max.floor, coords.transpose[1].min.ceil]
end

def line_slope(line)
  return false if line.transpose.map { |x| x.reduce(&:-) }.any?(&:zero?)
  line.map! { |x| x.map(&:to_f) }
  (line[1][1] - line[0][1]) / (line[1][0] - line[0][0])
end

def line_intercept(line)
  slope = line_slope(line)
  line.map! { |x| x.map(&:to_f) }
  line[0][1] - slope * line[0][0]
end

def line_intersection(l1, l2)
  m1 = line_slope(l1)
  m2 = line_slope(l2)
  b1 = line_intercept(l1, m1)
  b2 = line_intercept(l2, m2)
  x = (b2 - b1) / (m1 - m2)
  y = (m1 * b2 - m2 * b1) / (m1 - m2)
  [x, y]
end

def check_range(value, range_ary)
  value.between?(range.min, range.max)
end

def check_intersection(inter, line)
  # checks intersection inter is on line segment
  x_in = check_range(inter[0], [line[0][0], line[1][0]])
  y_in = check_range(inter[1], [line[0][1], line[1][1]])
  x_in && y_in
end

def rectangle_rotation(a, b)
  # general routine:
  # establish rectangle, right handed from top right
  # rotate rectangle
  rectangle = rotate(rectangulate(a, b), 45)
  # get bounds of rotated rectangel in y axis
  ybounds = ybounds(rectangle)
  ps_in_rect = 0
  (ybounds[0]..ybounds[1]).each do |ypoint|
    # for each point, calculate intersect of
    # with each line in the rectangle
    l1 = [[0, ypoint], [1. ypoint]]
    yinters = []
    rectangle.each_with_index do |row, i|
      i2 = i + 1 < rectangle.count ? i + 1 : -1
      l2 = [[row], rectangle[i2]]
      yi = line_intersection(l1, l2)
      if check_intersection(yi, line2)
        yi > 0 ? yinters.push(yi.floor) : yinters.push(yi.ceil)
      end
    end
    ps_in_rect += yi.count > 1 ? (yi[0] - yi[1]).abs : yi[0]
  end
  ps_in_rect
end
