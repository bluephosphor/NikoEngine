require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(300,300)
  Testbox = nil
end

function love.update()
  Controller.getInputState()

  if GlobalState ~= State.PAUSE then
    StepOrder.world.eval()
  end

  StepOrder.UI.eval()
end

function love.draw()
  DrawOrder.background.eval()
  DrawOrder.world.eval()
  DrawOrder.UI.eval()
  Controller.reset()
end
