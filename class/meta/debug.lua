Debug = {
  menu = nil,
  ShowBoxes = false,
  ShowEntityInfo = false
}

Debug.toggle = function()
  Game.Debug = not Game.Debug
  if Game.Debug then
    GlobalState = State.MENU
    Debug.menu = UI.List(1,1,{
      {option = 'Show Collision Boxes', callback = function() Debug.ShowBoxes = not Debug.ShowBoxes end},
      {option = 'Show Entity Info'    , callback = function() Debug.ShowEntityInfo = not Debug.ShowEntityInfo end},
      {option = 'Show Instance list'  , callback = function() Instance.list() end},
    })
  elseif Debug.menu then
    GlobalState = State.GAME
    Instance.destroy(Debug.menu)
  end
end