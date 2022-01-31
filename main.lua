require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(300,300)
end

function love.update()
  Controller.getInputState()
  if Controller.key['d'] then Debug.toggle() end
  if not Game.Paused then StepOrder.eval() end
end

function love.draw()
  DrawOrder.background.eval()
  DrawOrder.world.eval()
  DrawOrder.UI.eval()
  Controller.reset()
end
