--- a short description
-- @classmod flipup
local super = require('src.gamelib.animated_sprite')

local flipup = {}

-- class table
local Flipup = super.new{
  animation_length = 4,
  animation_lifetime = 0.40,
  animation_speed = 10,
  height = 42,
  width = 32,
}

function Flipup:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.setColor(lutro and {255, 255, 255} or {1, 1, 1})
  super.new().draw(self)
end

function Flipup:update(dt)
  self.animation_lifetime = self.animation_lifetime - dt
  if self.animation_lifetime < 0 then return 'done' end
  super.new().update(self, -dt)
end

function flipup.new(o)
  local self = o or {}
  setmetatable(self, { __index = Flipup })
  self:set_texture(o.texture)
  return self
end

return flipup
