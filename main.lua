require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/room/test.obj', 'asset/room/texture_0.png', nil, {math.pi/2,0,0})
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
  DrawOrder.background.eval()
  Floor:draw()
  DrawOrder.world.eval()
  DrawOrder.UI.eval()
  Controller.reset()
end
