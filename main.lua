-- love shorthands
lg = love.graphics
lk = love.keyboard
la = love.audio
le = love.event
lm = love.math
lt = love.timer
ls = love.sound

-- assets
assets = require('libs.cargo').init('assets')

-- timing
Timer = require "libs.timer"

-- physics
vec = require 'libs.vector'
bump = require 'libs.bump'
wld = bump.newWorld()

-- globals
require 'libs.stuff'
plr_keys = {'q', 'w', 'e', 'r'}
key_to_num = {}
for i,k in ipairs(plr_keys) do
  key_to_num[k] = i
end
plr_clrs = {colors.orange, colors.green, colors.blue, colors.purple}
numberOfPlayers = nil
sw = 800
sh = 600

-- classes
class = require 'libs.middleclass'
AABB = require 'classes.AABB'
Wall = require 'classes.Wall'
Player = require 'classes.Player'
Orb = require 'classes.Orb'

debug = true
function draw_bump()
  if debug then
    local items, len = wld:getItems()
    for i = 1, len do
      local item = items[i]
      local wx, wy, ww, wh = wld:getRect(item)
      lg.setColor(0, 1, 0)
      lg.rectangle('line', wx, wy, ww, wh)
    end
  end
end -- for debugging

-- states
gamestate = require 'libs.gamestate'
states = {}
states.title = require 'states.title'
states.howtoplay = require 'states.howtoplay'
states.game = require 'states.game'
states.results = require 'states.results'

-- visuals
fonts = {med = assets.fonts.droid(64),
          big = assets.fonts.droid(86),
          bigger = assets.fonts.droid(128)}
fw = {big = fonts.big:getWidth('A')}
btn = {open = assets.sprites.open, down = assets.sprites.down}

function draw_btn(x, y, state, num)
  lg.setColor(plr_clrs[num])
  lg.draw(btn[state], x, y)

  local offset = 0
  if state == 'down' then offset = 16 end

  lg.setFont(fonts.big)
  lg.setColor(0, 0, 0)
  lg.print(string.upper(plr_keys[num]), x + (120 - fw.big) / 2, y + offset -6)
end

function draw_sel(statuses, num)
  for i = 1, num do
    local nx = 200 * i - 100 - 64
    draw_btn(nx, 430, statuses[i], i)
  end
end

function love.load()
  numberOfPlayers = 1
  gamestate.registerEvents()
  gamestate.switch(states.title)

  lg.setFont(fonts.med)
end

function love.update(dt)
  Timer.update(dt)
end

function love.keypressed(k)
  if k == 'escape' then
    le.quit()
  end
end
