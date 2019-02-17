local results = {}

function results:enter(from, score)
  self.score = score
  self.statuses = {'open', 'open', 'open', 'open'}
end

function results:leave()

end

function results:update(dt)
  local ready = true
  self.statuses = {'open', 'open', 'open', 'open'}
  for i = 1, numberOfPlayers do
    ready = ready and lk.isDown(plr_keys[i])
    if lk.isDown(plr_keys[i]) then self.statuses[i] = 'down' end
  end

  if ready then
    gamestate.switch(states.title)
  end
end

function results:draw()
  lg.setBackgroundColor(colors.mint)

  lg.setFont(fonts.big)
  lg.setColor(1, 1, 1)
  lg.printf('Results', 5, 65, 800, 'center')
  lg.setColor(0, 0, 0)
  lg.printf('Results', 0, 70, 800, 'center')
  lg.printf('Score: ' .. self.score, 0, 140, 800, 'center')

  lg.setFont(fonts.med)
  lg.printf('Hold all to reset!', 0, 330, 800, 'center')
  draw_sel(self.statuses, numberOfPlayers)
end

function results:keypressed(k)

end


return results
