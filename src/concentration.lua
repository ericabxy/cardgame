--- a short description
-- @classmod concentration
local board = require('src.concentration.matching_board')

local concentration = {}

-- class table
local Concentration = {
  width = 320,
  height = 200,
  board = board.new(),
  cursor = {x = 160, y = 100},
  matches = 0,
  score = 0,
  tries = {0, 45}
}

function Concentration:button_reveal(b)
  if self.board:reveal(self.cursor.x, self.cursor.y) then
    return true
  end
end

function Concentration:is_ready_to_match()
  return #self.board.revealed >= self.board.nmatch
end

function Concentration:check_for_matches()
  if self.board:domatch() then
    self.score = self.score + 100
    return true
  else
    self.tries[1] = self.tries[1] + 1
    return false
  end
end

function Concentration:return_unmatched_cards()
  if self.board:conceal() then
    return true
  end
end

function Concentration:startup(...)
--check args for data here, paint errors if missing
--needs: cardfont
--needs: sound1 and sound2 (maybe)
  self.board = board.new()
  self.board:setup()
end

-- relative trackball movement
function Concentration:trackball_move(x, y)
  local left, top = 0, 0
  self.cursor.x = self.cursor.x + x
  self.cursor.y = self.cursor.y + y
  if self.cursor.x < left then self.cursor.x = left end
  if self.cursor.y < top then self.cursor.y = top end
  if self.cursor.x > self.width then self.cursor.x = self.width end
  if self.cursor.y > self.height then self.cursor.y = self.height end
end

-- absolute trackball position
function Concentration:trackball_set(x, y)
  self.cursor.x = x
  self.cursor.y = y
  self:trackball_move(0, 0)
end

function concentration.new(o)
  local self = o or {}
  setmetatable(self, { __index = Concentration })
  return self
end

return concentration
