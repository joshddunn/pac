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
