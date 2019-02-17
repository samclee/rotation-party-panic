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


	lg.setFont(fonts.med)
	lg.print('Touch these', 100, 80)
	lg.print('Avoid these', 100, 170)
	lg.printf('Hold all to start!', 0, 330, 800, 'center')
	
	lg.setColor(0, 0, 0)
	lg.circle('fill', 470, 115, 20)
	lg.setColor(1, 1, 1)
	lg.circle('fill', 470, 115, 40/3 + lm.random() * 3)

	lg.setColor(1, 0, 0)
	lg.translate(470, 205)
	lg.polygon('fill', 0,30,  30,0,  0,-30,  -30,0)
	lg.origin()

	draw_sel(self.statuses, numberOfPlayers)
end

function howtoplay:keypressed(k)

end


return howtoplay