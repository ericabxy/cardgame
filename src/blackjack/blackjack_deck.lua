--- a short description
-- @classmod blackjack_deck
local french_deck = require('src.cardgame.french_deck')

local blackjack_deck = {}

-- class table
local BlackjackDeck = french_deck.new{}

function blackjack_deck.new(o)
  local self = o or {}
  setmetatable(self, { __index = BlackjackDeck })
  return self
end

return blackjack_deck
