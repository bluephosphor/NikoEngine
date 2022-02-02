require "game"

function love.load()
  Game.Initialize()
  Player = NewPlayer(300,300)
  Testbox = nil
end

function love.update()
  Controller.getInputState()

  if Controller.key['t'] and not Testbox then
    TestBox = UI.Textbox({
      {text = "Hello, World!"},
      {text = "Nice to meet you."},
      {text = "How are we feeling?"},
      {text = "Stupid?"},
      {text = "Me too!"},
    })
  end

  if Controller.key['d'] then Debug.toggle() end
  
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
