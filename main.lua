require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(300,300)
end

function love.update()
  Controller.getInputState()
  if not Game.Paused then StepOrder.eval() end
  Controller.reset()
end

function love.draw()
  DrawOrder.background.eval()
  DrawOrder.world.eval()
  DrawOrder.UI.eval()
end
