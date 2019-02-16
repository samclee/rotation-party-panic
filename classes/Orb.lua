local Orb = class('Orb', AABB)

function Orb:initialize(x, y, w, h, n)
	AABB.initialize(self, x, y, w, h)
	self.id = 'Orb'
	self.num = n
	self.dead = false

	wld:add(self, self:getRect())
end

function Orb:update()

end

function Orb:draw()
	local c = self:getCenter()
	lg.setColor(plr_clrs[self.num])
	lg.circle('fill', c.x, c.y, self.w / 2)
end

function Orb:die()
	wld:remove(self)
	self.dead = true
end

return Orb