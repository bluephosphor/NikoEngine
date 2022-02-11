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
  DrawOrder.world.eval()
  Render3D()
  DrawOrder.UI.eval()
  Controller.reset()
  Color.set(Color.menuBack)
  love.graphics.rectangle("fill",0,0,100,32)
  Color.reset()
  love.graphics.print('fps: ' .. love.timer.getFPS())
  love.graphics.print('delta: ' .. floorToPrecision(love.timer.getDelta(),4), 0, 8)
  love.graphics.print('stepTime: ' .. floorToPrecision(love.timer.step(),4), 0, 16)
end
