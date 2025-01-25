--- a simple map of characters for text and tile graphics
-- @classmod src.gamelib.charmap
local charmap = {}

-- class table
local Charmap = {
  charheight = 8,
  charwidth = 8,
  map =
    '0000000000000000'..
    '0000000000000000'..
    '0000000000000000'..
    '0000000000000000',
  width = 64,
  x = 0,
  y = 0,
}

function Charmap:clear(s, n)
  s, n = s or '0', n or math.floor(self.width / self.charwidth)
  self.map = ''
  for x = 1, n do
    self.map = self.map .. s
  end
end

-- return the x,y position of character x
function Charmap:coordinates(x)
  local linewidth = math.floor(self.width / self.charwidth)
  local y = math.floor(x / linewidth) * self.charheight
  local x = (-1 + x % linewidth) * self.charwidth
  return self.x + x, self.y + y
end

function Charmap:draw()
  local off = lutro and 1 or 0
  love.graphics.setFont(self.font)
  love.graphics.printf(
    self.map, self.x, self.y, self.width - off, 'left'
  )
end

--return the parameters for drawing
function Charmap:get()
  local off = lutro and 1 or 0
  return self.map, self.x, self.y, self.width - off, 'left'
end

-- return position after a series of moves
function Charmap:movement(pos, moves)
  local linewidth = math.floor(self.width / self.charwidth)
  for x = 1, #moves do
    local move = string.sub(moves, x, x)
    if string.lower(move) == 'u' then
      pos = pos - linewidth
    elseif string.lower(move) == 'd' then
      pos = pos + linewidth
    elseif string.lower(move) == 'l' then
      pos = pos - 1
    elseif string.lower(move) == 'r' then
      pos = pos + 1
    end
  end
  return pos
end

-- non-text charmaps must break at width and contain no spaces
function Charmap:padded(s)
  local linewidth = math.floor(self.width / self.charwidth)
  local spacechar = '_'
  local emptychar = '-'
  s = string.gsub(s, ' ', spacechar)
  for x = #s, linewidth - 1 do
    s = s .. emptychar
  end
  return s
end

-- return character at location
function Charmap:peek(x)
  if x and x > 0 and x <= #self.map then
    return string.sub(self.map, x, x)
  end
end

-- return position of character at point
function Charmap:point(x, y)
  if x < self.x or x > self.x + self.width then return end
  if y < self.y then return end
  local linewidth = math.floor(self.width / self.charwidth)
  x, y = x - self.x, y - self.y
  charx, chary = math.floor(x / self.charwidth), math.floor(y / self.charheight)
  return 1 + charx + chary * linewidth
end

-- change character at location
function Charmap:poke(x, s)
  self.map = string.sub(self.map, 1, x - 1) .. s .. string.sub(self.map, x + 1)
end

function Charmap:set_lines(...)
  local linewidth = math.floor(self.width / self.charwidth)
  self.map = ''
  for _, s in ipairs({...}) do
    self.map = self.map .. string.format('%-' .. linewidth .. 's', s)
  end
end

function charmap.new(o)
  local self = o or {}
  setmetatable(self, { __index = Charmap })
  return self
end

return charmap
