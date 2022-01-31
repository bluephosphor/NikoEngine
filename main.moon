require('game')

love.load = ()->
  Game\Initialize()
  Player = NewPlayer(300,300)

love.update = ()->
  Controller\getInputState()
  if Controller.key['d'] 
    Debug\toggle()
  if not Game.Paused 
    StepOrder\eval()

love.draw = ()->
  DrawOrder.background\eval()
  DrawOrder.world\eval()
  DrawOrder.UI\eval()
  Controller\reset()