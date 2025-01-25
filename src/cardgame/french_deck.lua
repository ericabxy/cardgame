--- a short description
-- @classmod french_deck
local deck = require('src.cardgame.deck')

local french_deck = {}

-- class table
local FrenchDeck = deck.new{
  ranks = {
    'Ace', 'Two', 'Three', 'Four', 'Five',
    'Six', 'Seven', 'Eight', 'Nine', 'Ten',
    'Jack', 'Queen', 'King'},
  suits = {
    [0] = 'Spades',
    [16] = 'Hearts',
    [32] = 'Diamonds',
    [48] = 'Clubs',
  },
}

function french_deck.new(o)
  local self = o or {}
  setmetatable(self, { __index = FrenchDeck })
  return self
end

return french_deck
