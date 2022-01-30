require "game"
require "class.world.player"
require "class.UI.list"


function love.load()
  Game.Initialize()
  Menu = UI.List(8,8,{
    {option = 'Hello',      callback = nil},
    {option = 'Pick',       callback = nil},
    {option = 'An',         callback = nil},
    {option = 'Option :)',  callback = nil},
  })
  Player = NewPlayer(300,300)
end

function love.update()
  Controller.getInputs()
  if not Game.Paused then StepOrder.eval() end
  Controller.reset()
end

function love.draw()
  DrawOrder.background.eval()
  DrawOrder.world.eval()
  DrawOrder.UI.eval()
end
