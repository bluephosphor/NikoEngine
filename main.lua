require "game"

function love.load()
  Engine.Initialize()
  Game.Initialize()
end

function love.update(dt)
  Controller.getInputState()
  
  DTQueue.insert(dt)
  local adt = DTQueue.getAverage()
  
  if Engine.State ~= "PAUSED" and dt < 0.2 then
    StepOrder.world.eval(adt)
  end

  StepOrder.UI.eval()
  Engine.Update(dt)
end

function love.draw()
  if not Debug.ShowWire then Background.draw() end
  Engine.draw()
end
