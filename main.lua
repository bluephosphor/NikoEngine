require "init"
require "class.player"

function love.load()
  Initialize()
  Player = NewPlayer(300,300)
end

function love.update()
  Player.step()
end

function love.draw()
  love.graphics.setFont(Font.default)
  Player.draw()
  -- Player.drawBbox()
  -- Player.drawDebug(8,8)
end
