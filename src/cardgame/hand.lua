--- a short description
-- @classmod hand
local hand = {}

-- class table
local Hand = {}

function hand.new(o)
  local self = o or {}
  setmetatable(self, { __index = Hand })
  return self
end

return hand
