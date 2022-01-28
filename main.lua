require "player"

function love.load()
  Player = NewPlayer(300,300)
end

function love.update()
  Player.step()
end

function love.draw()
  Player.draw()
  Player.drawDebug()
end
