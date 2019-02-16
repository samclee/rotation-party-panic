local results = {}

function results:enter(from, scores)
  self.scores = scores
end

function results:leave()

end

function results:update(dt)
  local ready = true
  for _, key in pairs(plr_keys) do
    ready = ready and lk.isDown(key)
  end

  if ready then
    gamestate.switch(states.game)
  end
end

function results:draw()
  lg.setBackgroundColor(colors.mint)

  lg.setColor(0, 0, 0)
  lg.printf('Results', 0, 200, 800, 'center')
  for p = 1, numberOfPlayers do
    lg.printf('Player ' .. p .. ': ' .. self.scores[p], 0, 200 + p * 50, 800, 'center')
  end

  lg.printf('Hold q, w, e, and r to restart!', 0, 500, 800, 'center')
end

function results:keypressed(k)

end


return results
