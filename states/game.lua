local game = {}

local pd = 60
local wall_w = 10
local od = 40
local hd = 40
local walls, player, orbs, hzds

--framerate correction
tick_time = 1 / 70
accum = 0.0

-- orb spawning
spawning = false

-- countdown
init_time = 30
time_left = 0

function game:init()
  walls = {Wall:new(0, 0, wall_w, sh),
    Wall:new(sw - wall_w, 0, wall_w, sh),
    Wall:new(0, 0, sw, wall_w),
  Wall:new(0, sh - wall_w, sw, wall_w)}
  player = Player((sw - pd) / 2, (sh - pd) / 2, pd, pd, 15)

  spawning = true
  Timer.every(1, addOrb)
  Timer.every(1, decTime)
  orbs = {}
  hzds = {Hazard:new(10, 150, hd, hd),
    Hazard:new(20, 300, hd, hd),
  Hazard:new(20, 450, hd, hd)}
end

function game:enter()
  lg.setBackgroundColor(colors.beige)
  music = la.newSource("assets/sounds/main.ogg", "stream")
  music:play()
  music:setLooping(true)
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
  music:stop()
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

  -- update orbs
  for i, h in pairs(hzds) do
    h:update()
  end
end

function game:draw()
  -- timer
  lg.setColor(0, 0, 0)
  lg.setFont(fonts.big)
  lg.print('Time left: '..time_left, 30, 30)

  -- points
  lg.setFont(fonts.bigger)
  local pw = fonts.bigger:getWidth(tostring(player.score))
  lg.print(player.score, (sw - pw) / 2, 100)

  -- orbs
  for _, o in pairs(orbs) do
    o:draw()
  end

  -- hazards
  for _, h in pairs(hzds) do
    h:draw()
  end

  -- player
  player:draw()

  -- walls
  for _, w in pairs(walls) do
    w:draw()
  end

  -- timer
  lg.setFont(fonts.big)
  lg.setColor(plr_clrs[player.cur_plr])
  lg.print('Time left: '..time_left, 33, 27)
  lg.setColor(0, 0, 0)
  lg.print('Time left: '..time_left, 30, 30)

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
  if k == 'space' then
    for k, v in pairs(hzds) do
      print(v.pos)
    end
  end
end


return game
