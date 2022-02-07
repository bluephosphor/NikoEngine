require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/room/test2.obj', 'asset/room/texture_0.png', nil, {math.pi/2,0,0})
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
  love.graphics.setCanvas(WorldSurface)

  DrawOrder.world.eval()
  love.graphics.clear()

  Floor:draw()
  DrawOrder.world3D.eval()

  love.graphics.setCanvas()
  love.graphics.draw(WorldSurface[1])
  DrawOrder.UI.eval()
  Controller.reset()
end
