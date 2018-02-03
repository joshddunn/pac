function pac.print(phrase, x, y, color)
  if color == nil then
    color = 6
  end

  if x == "left" then
    x = 0
  elseif x == "center" then
    x = 64 - #phrase * 2
  elseif x == "right" then
    x = 128 - #phrase * 4
  end

  if y == "top" then
    y = 0
  elseif y == "middle" then
    y = 60
  elseif y == "bottom" then
    y = 123
  end

  print(phrase, x, y, color)
end
