local results = {}

function results:enter(from, scores)
  self.scores = scores
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
  for p = 1, numberOfPlayers do
    lg.printf('Player ' .. p .. ': ' .. self.scores[p], 0, 200 + p * 50, 800, 'center')
  end

  draw_sel(self.statuses, numberOfPlayers)
end

function results:keypressed(k)

end


return results
