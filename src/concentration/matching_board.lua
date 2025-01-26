--- a short description
-- @classmod matching_board
local charmap = require('src.gamelib.charmap')
local deck = require('src.concentration.matching_deck')

local matching_board = {}

-- class table
local MatchingBoard = {
  charmap_t = charmap.new{
    width = 272,
    x = 24, y = 26,
    charwidth = 34,
    charheight = 42,
  },
  deck = deck.new(),
  matched = {},
  nmatch = 2,  --number of cards in a match (default doubles)
  revealed = {},
  width = 272,
  unreveal = {},
}

function MatchingBoard:conceal()
  local coords = {}
  for x = #self.unreveal, 1, -1 do
    self.charmap_t:poke(self.unreveal[x], '@')
    table.insert(coords, {self.charmap_t:coordinates( self.unreveal[x] )})
    table.remove(self.unreveal, x)
  end
  return coords
end

function MatchingBoard:domatch()
  if #self.revealed < self.nmatch then return end
  for _, n1 in ipairs(self.revealed) do
    local n2 = self.revealed[self.nmatch]
    if self.deck.cards[n1] ~= self.deck.cards[n2] then
      for x = #self.revealed, 1, -1 do
        table.insert(self.unreveal, self.revealed[ x ])
        table.remove(self.revealed, x)
      end
      return
    end
  end
  for x = #self.revealed, 1, -1 do
    table.insert(self.matched, self.revealed[ x ])
    table.remove(self.revealed, x)
  end
  return true
end

function MatchingBoard:reveal(x, y)
  if #self.revealed >= self.nmatch then return end
  if #self.unreveal > 0 then return end
  local n = self.charmap_t:point(x, y)
  if self.charmap_t:peek(n) ~= '@' then return end
  local card = self.deck.cards[n]
  self.charmap_t:poke(n, card:get_ascii( ))
  table.insert(self.revealed, n)
  return self.charmap_t:coordinates(n)
end

function MatchingBoard:setup()
  self.deck:reshuffle()
  self.deck:shuffle()
  self.charmap_t:clear('@', #self.deck.cards)
end

function matching_board.new(o)
  local self = o or {}
  setmetatable(self, { __index = MatchingBoard })
  return self
end

return matching_board
