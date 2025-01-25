--- manage a texture and tile
-- @classmod gamelib.sprite
local color = require('src.gamelib.color')

local sprite = {}

-- class table
local Sprite = {
  texture = 'Texture',
  quad = 'Quad',
  color = color.white,
  width = 16,
  height = 16,
  ox = 0,
  oy = 0,
  x = 0,
  y = 0,
}

function Sprite:draw(x, y)
  if not self.texture then return end
  x = x and self.x + x or self.x
  y = y and self.y + y or self.y
  love.graphics.setColor(self.color)
  love.graphics.draw(self.texture, self.quad, x + self.ox, y + self.oy)
end

function Sprite:set_texture(texture, x, y)
  local width, height = texture:getDimensions()
  self.texture = texture
  self.quad = love.graphics.newQuad(x or 0, y or 0, self.width, self.height, width, height)
  return self
end

function sprite.new(o)
  local self = o or {}
  setmetatable(self, { __index = Sprite })
  return self
end

return sprite
