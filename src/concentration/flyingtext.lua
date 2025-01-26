--- a short description
-- @classmod flyingtext
local flyingtext = {}

-- class table
local Flyingtext = {
  x = 0,
  y = 0,
  map = 'MESSAGE',
  speed = 10,
  timer = 3.00,
}

function Flyingtext:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', self.x, self.y, 56, 8)
  love.graphics.setColor(lutro and {255, 255, 255} or {1, 1, 1})
  love.graphics.print(self.map, self.x, self.y)
end

function Flyingtext:get()
  return self.map, self.x, self.y
end

-- advance animation/timer by some time
function Flyingtext:update(dt)
  self.timer = self.timer - dt
  self.y = self.y + dt * self.speed
  return self.timer < 0 and 'done'
end

function flyingtext.new(o)
  local self = o or {}
  setmetatable(self, { __index = Flyingtext })
  return self
end

return flyingtext
