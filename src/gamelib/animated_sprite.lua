--- a simple animated texture object
-- @classmod gamelib.animated_sprite
local sprite = require('src.gamelib.sprite')

local animated_sprite = {}

-- class table
local AnimatedSprite = sprite.new{
  animation_length = 2,
  animation_speed = 30,
  animation_time = 0,
}

function AnimatedSprite:update(dt)
  self.animation_time =
    (self.animation_time + dt * self.animation_speed) % self.animation_length
  local x = math.floor(self.animation_time) * self.width
  self.quad:setViewport(x, 0, self.width, self.height)
end

function animated_sprite.new(o)
  local self = o or {}
  setmetatable(self, { __index = AnimatedSprite })
  return self
end

return animated_sprite
