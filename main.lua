require "game"

function love.load()
  Engine.Initialize()
  Game.Initialize()
end

function love.update(dt)
  Controller.getInputState()

  if Engine.State ~= "PAUSED" then
    StepOrder.world.eval(dt)
  end

  StepOrder.UI.eval()
  Engine.Update(dt)
end

function love.draw()
  Background.draw()
  Engine.draw()
end
