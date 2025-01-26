--- a patience game of matching hidden cards
-- @classmod concentration
local board = require('src.concentration.matching_board')
local charmap = require('src.gamelib.charmap')
local flipdown = require('src.concentration.flipdown')
local flipup = require('src.concentration.flipup')
local flyingtext = require('src.concentration.flyingtext')

local concentration = {}

-- class table
local Concentration = {
  animations = {},  --sprite and text animations
  width = 320,
  height = 200,
  board = board.new(),
  cardanim = false,  --sprite sheet for card animations
  cardfont = false,  --font for drawing cards on board
  cursor = {x = 160, y = 100},
  matches = 0,
  score = 0,
  sourcebg = false,  --background music
  sourcefx = false,  --sounds to play
  sprites = {},  --cursors and arrows
  tries = {0, 45}
}

function Concentration:button_reveal(b)
  local x, y = self.board:reveal(self.cursor.x, self.cursor.y)
  if x and y then
    self.sourcefx[1]:play()
    table.insert(self.animations, flipup.new{
      x = x, y = y, texture = self.cardanim
    })
    return true
  end
end

function Concentration:is_ready_to_match()
  return #self.board.revealed >= self.board.nmatch
end

function Concentration:check_for_matches()
  if self.board:domatch() then
    self.score = self.score + 100
    self.sourcefx[3]:play()
  else
    self.tries[1] = self.tries[1] + 1
    table.insert(self.animations, flyingtext.new{map = 'NO MATCH'})
    self.sourcefx[2]:play()
  end
end

function Concentration:return_unmatched_cards()
  local coords = self.board:conceal()
  for _, xy in ipairs(coords) do
    self.sourcefx[1]:play()
    table.insert(self.animations, flipdown.new{
      x = xy[1],
      y = xy[2],
      texture = self.cardanim
    })
  end
end

-- verify data integrity and initialize components
function Concentration:startup()
--check args for data here, paint errors if missing
--needs: cardfont
--needs: sound1 and sound2 (maybe)
  print('checking graphics data...')
  print('cardanim... ', self.cardanim and 'OK' or 'MISSING')
  print('cardfont... ', self.cardfont and 'OK' or 'MISSING')
  print('sourcefx... ', self.sourcefx and 'OK' or 'MISSING')
  self.board = board.new()
  self.board.charmap_t.font = self.cardfont
  self.charmap0 = charmap.new{font = self.cardfont}
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
function Concentration:trackball_goto(x, y)
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
