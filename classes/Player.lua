local Player = class('Player', AABB)

function Player:initialize(x, y, w, h, s)
	AABB.initialize(self, x, y, w, h)
	self.spd = s
	self.id = 'Player'
	self.vel = vec(0, 0)
	self.cur_plr = 1
	self.score = 0

	-- tether shooter
	self.t_dir = vec(0, 1)

	-- physics
	wld:add(self, self:getRect())
	self.filter = function(item, other)
		if other.id == 'Wall' then
			return 'bounce'
		elseif other.id == 'Orb' then
			return 'cross'
		end
	end
end

function Player:update(dt)
	-- movement
	local nPos = self.pos + self.vel
	local aX, aY, cols, len = wld:move(self, nPos.x, nPos.y, self.filter)
	self.pos.x, self.pos.y = aX, aY
	self.t_dir:rotateInplace(math.rad(5))

	-- collision
	for i=1, len do
		local col = cols[i]
		if col.other.id == 'Wall' then
			local l = self.vel:len()
			self.vel = -self.vel
			
		elseif col.other.id == 'Orb' then
			self.score = self.score + 1
			col.other:die()
		end
	end

	-- decelerate
	self.vel = self.vel * 0.95
	if self.vel:len() < 0.1 then 
		self.vel.x, self.vel.y = 0, 0
	end
end

function Player:draw()
	-- tether
	lg.setColor(plr_clrs[self.cur_plr])
	local c = self:getCenter()
	local ang = self.t_dir:angleTo() - math.pi / 2
	lg.draw(assets.sprites.arrow, c.x, c.y, ang, 1, 1, 25)

	-- body
	lg.setColor(0, 0, 0)
	lg.rectangle('fill', self.pos.x - 5, self.pos.y - 5, self.w + 10, self.h + 10)
	lg.setColor(plr_clrs[self.cur_plr])
	lg.rectangle('fill', self:getRect())

	-- indicator
	lg.setColor(0, 0, 0)
	local c = self:getCenter()
	lg.setFont(fonts.med)
	lg.print(string.upper(plr_keys[self.cur_plr]), self.pos.x + self.w / 4, self.pos.y)
end

function Player:accelerate(k)
	if k == plr_keys[self.cur_plr] then
		self.vel = self.vel + self.t_dir * self.spd
		self.cur_plr = (self.cur_plr % numberOfPlayers) + 1
	end
end

function Player:teleport(x, y)
    wld:update(self, x, y)
    self.pos.x, self.pos.y = x, y
end

return Player