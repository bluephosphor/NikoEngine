require "game"

local accumulator = 0
local frametime = 1/60
local rollingAverage = {}

function love.load()
  Game.Initialize()
  Room.current = DefineRoom('test')
  Player = NewPlayer()
  Room.spawn(Player,0,-5)
end

function love.update(dt)
  Controller.getInputState()

  if Game.State ~= "PAUSED" then
    StepOrder.world.eval(dt)
  end

  StepOrder.UI.eval()
  Game.Update(dt)
end

function love.draw()
  DrawOrder.world.eval()
  Render3D()
  DrawOrder.UI.eval()
  Controller.reset()
  love.graphics.print('fps: ' .. love.timer.getFPS())
  love.graphics.print('delta: ' .. love.timer.getDelta(), 0, 8)
  love.graphics.print('stepTime: ' .. love.timer.step(), 0, 16)
end
