local title = {}

function title:enter()
  music = love.audio.newSource("assets/sounds/title.ogg", "stream")
  music:setLooping(true)
  music:play()
end

function title:leave()
end

function title:update(dt)

end

function title:draw()
  lg.setBackgroundColor(colors.pink)

  lg.setFont(fonts.big)
  lg.setColor(1, 1, 1)
  lg.printf('Tether Party Panic', 5, 95, 800, 'center')
  lg.setColor(0, 0, 0)
  lg.printf('Tether Party Panic', 0, 100, 800, 'center')

  lg.setFont(fonts.med)
  lg.printf('PLAYER SELECT', 0, 270, 800, 'center')

  for i = 1, 4 do
    local nx = 200 * i - 100 - 14
    lg.setFont(fonts.med)
    lg.print(i, nx, 350)
  end
  draw_sel({'open', 'open', 'open', 'open'}, 4)
end

function title:keypressed(key)
  local n = key_to_num[key]
  if n ~= nil then
    numberOfPlayers = n
    keysarestilldown = true
    gamestate.switch(states.howtoplay)
  end
end

return title
