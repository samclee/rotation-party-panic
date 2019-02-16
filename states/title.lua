local title = {}

function title:enter()

end

function title:leave()

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