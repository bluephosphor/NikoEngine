require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(0,0)
  Floor = G3D.newModel('asset/room/test.obj', 'asset/room/texture_0.png', nil, {math.pi/2,0,0})
  WorldSurface = {
    love.graphics.newCanvas(
      Game.Resolution.width,
      Game.Resolution.height
    ),
    depth = true,
    stencil = true
  }
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
  DrawOrder.background.eval()
  DrawOrder.world.eval()
  love.graphics.clear()
  Floor:draw()
  Player.model:draw()
  love.graphics.setCanvas()
  love.graphics.draw(WorldSurface[1])
  DrawOrder.UI.eval()
  Controller.reset()
end
