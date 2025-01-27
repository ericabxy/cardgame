--- a short description
-- @classmod blackjack
local deck = require('src.blackjack.blackjack_deck')

local blackjack = {}

-- class table
local Blackjack = {
  deck = deck.new(),
}

function Blackjack:Blackjack()
  self.deck:reshuffle()
  self.deck:shuffle()
  for x, card in ipairs(self.deck.cards) do
    card:set_texture(self.cardsimg)
    if x < 8 then
      card.x = x * 25 - 25
      card.y = 150
    end
  end
end

function Blackjack:draw()
  for _, card in ipairs(self.deck.cards) do
    card:draw()
    love.graphics.print(card:get_code(), card.x, card.y + 57)
  end
end

function blackjack.new(o)
  local self = o or {}
  setmetatable(self, { __index = Blackjack })
  return self
end

return blackjack
