--- a short description
-- @classmod tarot_deck
local deck = require('src.cardgame.deck')

local tarot_deck = {}

-- class table
local TarotDeck = deck.new{
  ranks = {
    'Ace', 'Two', 'Three', 'Four', 'Five',
    'Six', 'Seven', 'Eight', 'Nine', 'Ten',
    'Jack', 'Knight', 'Queen', 'King',
  },
  suits = {
    [0] = 'Spades',
    [16] = 'Hearts',
    [32] = 'Diamonds',
    [48] = 'Clubs',
  },
}

function tarot_deck.new(o)
  local self = o or {}
  setmetatable(self, { __index = TarotDeck })
  return self
end

return tarot_deck
