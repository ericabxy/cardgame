--- a short description
-- @classmod flipdown
local super = require('src.gamelib.animated_sprite')

local flipdown = {}

-- class table
local Flipdown = super.new{
  animation_length = 4,
  animation_lifetime = 0.40,
  animation_speed = 10,
  height = 42,
  width = 32,
}

function Flipdown:update(dt)
  self.animation_lifetime = self.animation_lifetime - dt
  if self.animation_lifetime < 0 then return 'done' end
  super.new().update(self, dt)
end

function flipdown.new(o)
  local self = o or {}
  setmetatable(self, { __index = Flipdown })
  return self
end

return flipdown
