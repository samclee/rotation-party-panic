local howtoplay = {}

function howtoplay:enter()

end

function howtoplay:leave()

end

function howtoplay:update(dt)
	local ready = true
	for _,key in pairs(plr_keys) do
		ready = ready and lk.isDown(key)
	end

	if ready then
		gamestate.switch(states.game)
	end
end

function howtoplay:draw()
	lg.setBackgroundColor(colors.powderblue)
	lg.setColor(0, 0, 0)
	lg.printf('Collect the most of your color orb!', 0, 300, 800, 'center')
	lg.printf('Hold q, w, e, and r to start!', 0, 350, 800, 'center')
end

function howtoplay:keypressed(k)

end


return howtoplay