--- a short description
-- @classmod blackjack_hand
local hand = require('src.cardgame.hand')
local sprite = require('src.gamelib.sprite')

local blackjack_hand = {}

-- class table
local BlackjackHand = hand.new{
  sprite = sprite.new(),
}

function BlackjackHand:take(cards)
  for _, card in ipairs(cards) do
  end
end

function blackjack_hand.new(o)
  local self = o or {}
  setmetatable(self, { __index = BlackjackHand })
  return self
end

return blackjack_hand
