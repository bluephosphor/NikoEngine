require "game"
require "class.world.player"

function love.load()
  Game.Initialize()
  Player = NewPlayer(300,300)
  Player2 = NewPlayer(600,300)
end

function love.update()
  Game.Loop()
end

function love.draw()
  Game.Render()
end
