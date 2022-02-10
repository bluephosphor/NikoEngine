require "game"

function love.load()
  Game.Initialize()
  Room.current = DefineRoom('test')
  Room.spawn(NewPlayer(),0,-5)
end

function love.update()
  Controller.getInputState()

  if Game.State ~= "PAUSED" then
    StepOrder.world.eval()
  end

  StepOrder.UI.eval()
  Game.Update()
end

function love.draw()
  DrawOrder.world.eval()
  Render3D()
  DrawOrder.UI.eval()
  Controller.reset()
end
