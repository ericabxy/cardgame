--- a single playing card
-- @classmod card
local card = {}

local suit_t = {}

-- class table
local Card = {
  rank = 'Rank',
  suit = 'Suits',
  suit_value = 0,
  value = 0,
}

function Card:get_ascii()
  return string.char(64 + self.suit_value + self.value)
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
