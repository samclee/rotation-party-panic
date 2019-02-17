local game = {}

local pd = 60
local wall_w = 10
local od = 40
local walls, player, orbs

--framerate correction
tick_time = 1 / 70
accum = 0.0

-- orb spawning
spawning = false

-- countdown
init_time = 10
time_left = 0

function game:init()
  walls = {Wall:new(0, 0, wall_w, sh),
    Wall:new(sw - wall_w, 0, wall_w, sh),
    Wall:new(0, 0, sw, wall_w),
  Wall:new(0, sh - wall_w, sw, wall_w)}
  player = Player((sw - pd) / 2, (sh - pd) / 2, pd, pd, 12)

  spawning = true
  Timer.every(1, addOrb)
  Timer.every(1, decTime)
  orbs = {}
end

function game:enter()
  lg.setBackgroundColor(colors.beige)
  music = la.newSource("assets/sounds/main.ogg", "stream")
  music:play()
  lm.setRandomSeed(os.time())
  
  -- reset game
  player.vel.x, player.vel.y = 0, 0
  player.cur_plr = 1
  player.score = 0
  player:teleport((sw - pd) / 2, (sh - pd) / 2)
  time_left = init_time
  
  -- repopulate board
  for i = 1, 10 do addOrb() end
end

function game:leave()
  for _, orb in pairs(orbs) do
    orb:die()
  end
end

function game:update(dt)

  -- frame correction
  accum = accum + dt
  if accum < tick_time then
    return
  end
  accum = accum - tick_time

  -- game end
  if time_left == 0 then
    gamestate.switch(states.results, player.score)
  end

  -- update player
  player:update(dt)

  -- update orbs
  for i, o in pairs(orbs) do
    if o.dead then
      table.remove(orbs, i)
    end
  end
end

function game:draw()
  -- timer
  lg.setColor(0, 0, 0)
  lg.setFont(fonts.bigger)
  local time_w = fonts.bigger:getWidth(tostring(time_left))
  lg.print(time_left, (sw - time_w) / 2, 100)

  -- orbs
  for _, o in pairs(orbs) do
    o:draw()
  end

  -- player
  player:draw()

  -- walls
  for _, w in pairs(walls) do
    w:draw()
  end

  draw_bump()
end


function findOrbLoc()
  local l, r = wall_w + od, sw - wall_w - 2 * od
  local t, b = wall_w + od, sh - wall_w - 2 * od

  local nx = lm.random(l, r)
  local ny = lm.random(t, b)

  return nx, ny
end

function addOrb()
  if not spawning or #orbs > 15 then return end

  local nx, ny = findOrbLoc()
  add(orbs, Orb:new(nx, ny, od, od))
end

function decTime()
  if time_left > 0 then
    time_left = time_left - 1
  end
end

function game:keypressed(k)
  player:accelerate(k)
end


return game