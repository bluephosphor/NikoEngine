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
  if not Debug.ShowWire then Background.draw() end
  Engine.draw()
end
