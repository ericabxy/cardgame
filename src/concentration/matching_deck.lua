--- truncated deck for a game of Concentration
-- @classmod matching_deck
local french_deck = require('src.cardgame.french_deck')

local matching_deck = {}

-- class table
local MatchingDeck = french_deck.new{
  npacks = 2,
}

function MatchingDeck:reshuffle()
  for x = 2, 10 do
    self.ranks[x] = nil
  end
  french_deck.new().reshuffle(self)
end

function matching_deck.new(o)
  local self = o or {}
  setmetatable(self, { __index = MatchingDeck })
  return self
end

return matching_deck
