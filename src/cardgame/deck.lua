--- a short description
-- @classmod deck
local card = require('src.cardgame.card')

local deck = {}

-- class table
local Deck = {
  cards = {},
  npacks = 2,
  ranks = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'},
  suits = {'Black', 'White', 'Red', 'Blue'},
  top = 0,
  trumps = {'Bomb', 'Bomb'},
}

function Deck:reshuffle()
  self.cards = {}
  self.top = 0
  for _ = 1, self.npacks do
    for s, suit in pairs(self.suits) do
      for r, rank in pairs(self.ranks) do
        table.insert(self.cards, card.new{
          suit = suit,
          rank = rank,
          suit_value = s,
          value = r,
        })
        self.top = self.top + 1
      end
    end
  end
end

function Deck:shuffle()
  for x = self.top, 1, -1 do
    local random = love.math.random(1, self.top)
    local temp = self.cards[x]
    self.cards[x] = self.cards[random]
    self.cards[random] = temp
  end
end

function deck.new(o)
  local self = o or {}
  setmetatable(self, { __index = Deck })
  return self
end

return deck
