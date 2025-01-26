if not lutro then love.mouse.setVisible(false) end

local cardfont = require('tinycards_imagefont')
local cursor_img, cursor_quad = unpack(require('cursorpack'))
local game = require('src.concentration')
local textfont = require('dos_8x8_imagefont')

local revealsnd, misssnd, matchsnd = unpack(audio)
local game0 = game.new{
  cardanim = require('tinycards_animation'),
  cardfont = require('tinycards_imagefont'),
  sourcefx = require('audio_sources'),
}
local SCALE = lutro and 1.0 or 2.5

function love.load()
  game0:startup()
end

function love.update(dt)
  if not revealsnd:isPlaying() and game0:is_ready_to_match() then
    game0:check_for_matches()
  end
  if lutro then
  local mag = 2.00
  local x, y = love.joystick.getAxis(1, 1), love.joystick.getAxis(1, 2)
  game0:trackball_move(x * mag, y * mag)
  end
  for x = #game0.animations, 1, -1 do
    local anim = game0.animations[x]
    if anim:update(dt) == 'done' then
      table.remove(game0.animations, x)
    end
  end
end

function love.draw()
  if not lutro then love.graphics.scale(SCALE, SCALE) end
  --love.graphics.setFont(cardfont)
  --love.graphics.printf(game0.board.charmap_t:get( ))
  game0.board.charmap_t:draw()
  love.graphics.draw(
    cursor_img,
    cursor_quad,
    game0.cursor.x - 16,
    game0.cursor.y - 16
  )
  love.graphics.setFont(textfont)
  love.graphics.print(
    'MATCHES ' .. game0.matches .. ' ' ..
    'SCORE ' .. game0.score .. ' ' ..
    'TRIES ' .. game0.tries[1] .. '/' .. game0.tries[2],
    0,
    232
  )
  for _, anim in ipairs(game0.animations) do
    anim:draw()
  end
end

function love.joystickpressed(_, b)
  if b == 0 and not revealsnd:isPlaying() and not misssnd:isPlaying() then
    local x, y = game0:button_reveal()
    if x and y then
      --revealsnd:play()
    else
      if game0:return_unmatched_cards() then
        --revealsnd:play()
      end
    end
  end
end

if not lutro then--IFDEF
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.mousemoved(x, y)
  game0:trackball_goto(x / SCALE, y / SCALE)
end

function love.mousepressed(_, _, button)
  love.joystickpressed(_, 0)
end
end--END IFDEF
