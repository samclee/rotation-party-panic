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

-- classes
class = require 'libs.middleclass'
AABB = require 'classes.AABB'
Wall = require 'classes.Wall'
Player = require 'classes.Player'
Orb = require 'classes.Orb'

-- globals
require 'libs.stuff'
plr_keys = {'q', 'w', 'e', 'r'}
plr_clrs = {colors.orange, colors.green, colors.blue, colors.purple}
sw = 800
sh = 600

debug = true
function draw_bump()
	if debug then
		local items, len = wld:getItems()
		for i=1,len do
			local item = items[i]
			local wx,wy,ww,wh = wld:getRect(item)
			lg.setColor(0, 1, 0)
			lg.rectangle('line',wx,wy,ww,wh)
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

function love.load()
	gamestate.registerEvents()
	gamestate.switch(states.title)
end

function love.keypressed(k)
  if k == 'escape' then
    le.quit()
  end
end