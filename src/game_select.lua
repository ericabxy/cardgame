--- a short description
-- @classmod game_select
local game_select = {}

-- class table
local GameSelect = {}

function game_select.new(o)
  local self = o or {}
  setmetatable(self, { __index = GameSelect })
  return self
end

return game_select
