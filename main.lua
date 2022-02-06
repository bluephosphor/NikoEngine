require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/model/plane.obj', 'asset/sprite/starfield.png', {0,0,-1}, {0,0,0}, {25,50,25})
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
