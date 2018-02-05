-- default mode
mode = "game"

-- update and draw functions

update = {}
-- function _update60()
function _update()
  update[mode]()
end

draw = {}
function _draw()
  draw[mode]()
end

-- buttons
buttons = {
  left = 0,
  right = 1,
  up = 2,
  down = 3,
  o = 4,
  x = 5
}

-- colors
colors = {
  black = 0,
  dark_blue = 1
  dark_purple = 2,
  dark_green = 3,
  brown = 4,
  dark_grey = 5,
  light_grey = 6,
  white = 7,
  red = 8,
  orange = 9,
  yellow = 10,
  green = 11,
  blue = 12,
  indigo = 13,
  pink = 14,
  peach = 15
}
