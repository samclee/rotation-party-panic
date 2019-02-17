local Orb = class('Orb', AABB)

function Orb:initialize(x, y, w, h)
	AABB.initialize(self, x, y, w, h)
	self.id = 'Orb'
	self.dead = false

	wld:add(self, self:getRect())
end

function Orb:update()

end

function Orb:draw()
	local c = self:getCenter()
	lg.setColor(0, 0, 0)
	lg.circle('fill', c.x, c.y, self.w / 2)
	lg.setColor(1, 1, 1)
	lg.circle('fill', c.x, c.y, self.w / 3 + lm.random() * 3)
end

function Orb:die()
	wld:remove(self)
	self.dead = true
end

return Orb