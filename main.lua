require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/room/test/mesh.obj', 'asset/room/test/test_0.png', nil, {math.pi/2,0,0})
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
  love.graphics.setCanvas(WorldSurface)

  DrawOrder.world.eval()
  love.graphics.clear()
  --love.graphics.setWireframe(true)
  Floor:draw()
  DrawOrder.world3D.eval()
  --love.graphics.setWireframe(false)
  love.graphics.setCanvas()
  love.graphics.draw(WorldSurface[1])
  DrawOrder.UI.eval()
end
