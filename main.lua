if not lutro then love.mouse.setVisible(false) end

local audio = require('audio_sources')
local cardanim = require('tinycards_animation')
local cardfont = require('tinycards_imagefont')
local cursor_img, cursor_quad = unpack(require('cursorpack'))
local flipdown = require('src.animations.flipdown')
local flipup = require('src.animations.flipup')
local flyingtext = require('src.animations.flyingtext')
local game = require('src.concentration')
local textfont = require('dos_8x8_imagefont')

local matchsnd, revealsnd, misssnd = unpack(audio)
local card_animation = flipup.new(cardanim)
local game0 = game.new()
matchsnd:setVolume(0.40)
misssnd:setVolume(0.40)
revealsnd:setVolume(0.40)
local animations_t = {}
local SCALE = lutro and 1.0 or 2.5

function love.load()
  game0:startup()
end

function love.update(dt)
  if not revealsnd:isPlaying() and game0:is_ready_to_match() then
    if game0:check_for_matches() then
      matchsnd:play()
    else
      table.insert(animations_t, flyingtext.new{map = 'NO MATCH'})
      misssnd:play()
      --play a sad noise :(
    end
  end
  for x = #animations_t, 1, -1 do
    local text = animations_t[x]
    if not text:update(dt) then
      table.remove(animations_t, x)
    end
  end
  if lutro then
  local mag = 2.00
  local x, y = love.joystick.getAxis(1, 1), love.joystick.getAxis(1, 2)
  game0:trackball_move(x * mag, y * mag)
  end
  if card_animation then
    if card_animation:update(dt) == 'done' then
      card_animation = false
    end
  end
end

function love.draw()
  if not lutro then love.graphics.scale(SCALE, SCALE) end
  love.graphics.setFont(cardfont)
  love.graphics.printf(game0.board.charmap_t:get( ))
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
  for _, thing in ipairs(animations_t) do
    thing:draw()
  end
  card_animation:draw()
end

function love.joystickpressed(_, b)
  if b == 0 and not revealsnd:isPlaying() and not misssnd:isPlaying() then
    if game0:button_reveal() or
       game0:return_unmatched_cards() and
       game0:button_reveal() then
      revealsnd:play()
      card_animation = flipup.new(cardanim)
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
  game0:trackball_set(x / SCALE, y / SCALE)
end

function love.mousepressed(_, _, button)
  love.joystickpressed(_, 0)
end
end--END IFDEF
