local game = {}

local scores = {0, 0, 0, 0}
local pd = 60
local wall_w = 20
local od = 40
local walls, player, orbs

--framerate correction
tick_time = 1/70
accum = 0.0

-- orb spawning
to_spawn = 1
spawning = false

-- countdown
init_time = 10
time_left = 0

function game:init()
	walls = {Wall:new(0, 0, wall_w, sh),
				Wall:new(sw - wall_w, 0, wall_w, sh),
				Wall:new(0, 0, sw, wall_w),
				Wall:new(0, sh - wall_w, sw, wall_w)}
	player = Player((sw - pd) / 2, (sh - pd) / 2, pd, pd, 7)

	spawning = true
	Timer.every(1, addOrb)
	Timer.every(1, decTime)
	orbs={}
end

function game:enter()
	music = la.newSource("assets/sounds/main.ogg", "stream")
	music:play()
	lm.setRandomSeed(os.time())
	player.vel.x, player.vel.y = 0, 0
	player:teleport((sw - pd) / 2, (sh - pd) / 2)
	time_left = init_time
	scores = {0, 0, 0, 0}
	for i=1,10 do addOrb() end
end

function game:leave()
	for _, orb in pairs(orbs) do
		orb:die()
	end
end

function game:update(dt)
	Timer.update(dt)

	-- frame correction
	accum = accum + dt
	if accum < tick_time then
		return
	end
	accum = accum - tick_time

	-- game end
	if time_left == 0 then
		gamestate.switch(states.results, scores)
	end

	-- update player
	player:update(dt, scores)

	-- update orbs
	for i, o in pairs(orbs) do
		if o.dead then
			table.remove(orbs, i)
		end
	end
end

function game:draw()
	lg.setBackgroundColor(colors.beige)

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

	-- ui
	lg.setColor(0, 0, 0)
	lg.print('Scores '..scores[1]..' '..scores[2]..' '..scores[3]..' '..scores[4])
	lg.print('Time: ' .. time_left,0, 30)

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
	if not spawning or #orbs > 20 then return end

	local nx, ny = findOrbLoc()
	add(orbs, Orb:new(nx, ny, od, od, to_spawn))
	to_spawn = (to_spawn % 4) + 1
end

function decTime()
	if time_left > 0 then
		time_left = time_left - 1
	end
end

function game:keypressed(k)
	player:accelerate(k)

	if k == 'n' then gamestate.switch(states.results, scores) end
end


return game