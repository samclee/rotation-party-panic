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
  lg.printf('Press a key according to how many players you want, 1-4', 0, 400, 800, 'center')
end

function title:keypressed(key)
  if key == "1" then
    numberOfPlayers = 1
    gamestate.switch(states.howtoplay)
  end
  if key == "2" then
    numberOfPlayers = 2
    gamestate.switch(states.howtoplay)
  end
  if key == "3" then
    numberOfPlayers = 3
    gamestate.switch(states.howtoplay)
  end
  if key == "4" then
    numberOfPlayers = 4
    gamestate.switch(states.howtoplay)
  end
end

return title
