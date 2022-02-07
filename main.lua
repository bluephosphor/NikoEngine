require "game"
local room = 'field'

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/room/'.. room ..'/mesh.obj', 'asset/room/'.. room .. '/test_1.png', nil, {math.pi/2,0,0})
  Floor:makeNormals(false)
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
  love.graphics.setCanvas(WorldSurface)
  love.graphics.clear()
  --love.graphics.setWireframe(true)
  Floor:draw()
  DrawOrder.world3D.eval()
  --love.graphics.setWireframe(false)
  love.graphics.setCanvas()
  love.graphics.draw(WorldSurface[1])
  DrawOrder.UI.eval()
  Controller.reset()
end
