--- a short description
-- @classmod flipup
local super = require('src.gamelib.animated_sprite')

local flipup = {}

-- class table
local Flipup = super.new{
  animation_length = 4,
  animation_lifetime = 0.50,
  animation_speed = 10,
  height = 42,
  width = 32,
}

function Flipup:update(dt)
  self.animation_lifetime = self.animation_lifetime - dt
  if self.animation_lifetime < 0 then return 'done' end
  super.new().update(self, -dt)
end

function flipup.new(o)
  local self = o or {}
  setmetatable(self, { __index = Flipup })
  return self
end

return flipup
