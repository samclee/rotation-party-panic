local AABB = class('AABB')

function AABB:initialize(x, y, w, h)
	self.pos = vec(x, y)
	self.w = w
	self.h = h
end

function AABB:getRect()
	return self.pos.x, self.pos.y, self.w, self.h
end

function AABB:getCenter()
	return vec(self.pos.x + self.w / 2, self.pos.y + self.h / 2)
end

return AABB