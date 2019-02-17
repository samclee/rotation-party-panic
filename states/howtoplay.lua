local howtoplay = {}

function howtoplay:enter()
	self.statuses = {'open', 'open', 'open', 'open'}
end

function howtoplay:leave()

end

function howtoplay:update(dt)
	local ready = true
	self.statuses = {'open', 'open', 'open', 'open'}

	for i = 1, numberOfPlayers do
		ready = ready and lk.isDown(plr_keys[i])
		if lk.isDown(plr_keys[i]) then self.statuses[i] = 'down' end
	end

	if ready then
		gamestate.switch(states.game)
	end
end

function howtoplay:draw()
	lg.setBackgroundColor(colors.powderblue)
	lg.setColor(0, 0, 0)
	draw_sel(self.statuses, numberOfPlayers)
end

function howtoplay:keypressed(k)

end


return howtoplay