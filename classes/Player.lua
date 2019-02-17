local Player = class('Player', AABB)

function Player:initialize(x, y, w, h, s)
	AABB.initialize(self, x, y, w, h)
	self.spd = s
	self.id = 'Player'
	self.vel = vec(0, 0)
	self.cur_plr = 1

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

function Player:update(dt, scores)
	-- movement
	local nPos = self.pos + self.vel
	local aX, aY, cols, len = wld:move(self, nPos.x, nPos.y, self.filter)
	self.pos.x, self.pos.y = aX, aY
	self.t_dir:rotateInplace(math.rad(4))

	-- collision
	for i=1, len do
		local col = cols[i]
		if col.other.id == 'Wall' then
			local l = self.vel:len()
			self.vel = -self.vel
			
			for i, s in pairs(scores) do
				scores[i] = math.ceil(s / 2)
			end
		elseif col.other.id == 'Orb' then
			scores[col.other.num] = scores[col.other.num] + 5
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
	lg.setColor(0,1,1)
	local c = self:getCenter()
	local endpt = c + self.t_dir * 100
	lg.line(c.x, c.y, endpt.x, endpt.y)

	-- body
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