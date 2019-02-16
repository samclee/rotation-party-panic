local title = {}

function title:enter()
	--music = la.newSource("assets/sounds/title.ogg", "stream")
	--music:setLooping(true)
	--music:play()
end

function title:leave()
	--music:stop()
end

function title:update(dt)

end

function title:draw()
	lg.setBackgroundColor(colors.pink)
	lg.setColor(0, 0, 0)
	lg.printf('Tether Party Panic', 0, 200, 800, 'center')
	lg.printf('Press any key to continue', 0, 400, 800, 'center')
end

function title:keypressed(k)
	gamestate.switch(states.howtoplay)
end

return title