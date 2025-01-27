--- a single playing card
-- @classmod card
local super = require('src.gamelib.sprite')

local card = {}

local suit_t = {}

-- class table
local Card = super.new{
  rank = 'Rank',
  suit = 'Suits',
  suit_value = 0,
  value = 0,
}

function Card:get_ascii()
  return string.char(64 + self.suit_value + self.value)
end

function Card:get_code()
  local face = {[1] = 'A', [11] = 'J', [12] = 'C', [13] = 'Q', [14] = 'K'}
  local rank = face[self.value] or self.value
  local suit = string.sub(self.suit, 1, 1)
  return rank .. suit
end

function Card:get_name()
  return self.rank .. ' of ' .. self.suit .. ' ' .. self:get_ascii()
end

function Card:is_equal(card)
  return self.rank == card.rank and self.suit == card.suit
end

function Card:is_less_than(card)
  return self.value < card.value
end

function Card:is_less_than_or_equal(card)
  return self:is_less_than(card) or self:is_equal(card)
end

function Card:set_texture(texture)
  local x = self.value * texture:getWidth() / 16
  local y = (self.suit_value / 16) * texture:getHeight() / 4
  self.width = texture:getWidth() / 16
  self.height = texture:getHeight() / 4
  super.new().set_texture(self, texture, x, y)
end

function card.new(o)
  local self = o or {}
  setmetatable(self, {
    __eq = Card.is_equal,
    __lt = Card.is_less_than,
    __le = Card.is_less_than_or_equal,
    __index = Card,
    __tostring = Card.get_name
  })
  return self
end

return card
