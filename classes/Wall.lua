local Wall = class('Wall', AABB)

function Wall:initialize(x, y, w, h)
	AABB.initialize(self, x, y, w, h)
	self.id = 'Wall'

	wld:add(self, self:getRect())
	self.filter = function(item, other)
		if other.id == 'Player' or other.id == 'Hazard' then
			return 'bounce'
		end
	end
end

function Wall:update()

end

function Wall:draw()
	lg.setColor(colors.powderblue)
	lg.rectangle('fill', self:getRect())
end

return Wall