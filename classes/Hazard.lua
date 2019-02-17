local Hazard = class('Hazard', AABB)

function Hazard:initialize(x, y, w, h)
	AABB.initialize(self, x, y, w, h)
	self.spd = lm.random(2,5)
	self.vel = vec(1, 0)
	self.id = 'Hazard'
	
	wld:add(self, self:getRect())
	self.filter = function(item, other)
		if other.id == 'Wall' then
			return 'bounce'
		end
		return 'cross'
	end
end

function Hazard:update()
	local nPos = self.pos + self.vel * self.spd
	local aX, aY, cols, len = wld:move(self, nPos.x, nPos.y, self.filter)
	self.pos.x, self.pos.y = aX, aY

	-- collision
	for i=1, len do
		local col = cols[i]
		if col.other.id == 'Wall' then
			self.vel = -self.vel
		end
	end

	if self.pos.x > sw or self.pos.x < 0 or self.pos.y < 0 or self.pos.y > sh then
		self:reset()
	end
end

function Hazard:draw()
	lg.setColor(1, 0, 0)
	lg.translate(self.pos.x + self.w / 2, self.pos.y + self.h / 2)
	lg.polygon('fill', 0,30,  30,0,  0,-30,  -30,0)
	lg.origin()
end

function Hazard:reset()
	self.vel = vec(1, 0)
	self.spd = lm.random(2,5)
	self:teleport(self.w, lm.random(30, sh - 30))
end


function Hazard:teleport(x, y)
    wld:update(self, x, y)
    self.pos.x, self.pos.y = x, y
end

return Hazard