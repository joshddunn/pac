function pac.print(string, x, y, color)
  if color == nil then
    color = 6
  end

  if x == "left" then
    x = 0
  elseif x == "center" then
    x = 64 - #string * 2
  elseif x == "right" then
    x = 128 - #string * 4
  end

  if y == "top" then
    y = 0
  elseif y == "middle" then
    y = 60
  elseif y == "bottom" then
    y = 123
  end

  print(string, x, y, color)
end
