--- a short description
-- @classmod blackjack
local blackjack = {}

-- class table
local Blackjack = {}

function blackjack.new(o)
  local self = o or {}
  setmetatable(self, { __index = Blackjack })
  return self
end

return blackjack
