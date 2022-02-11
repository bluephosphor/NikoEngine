Debug = {
  menu = nil,
  ShowBoxes = false,
  ShowWire = false,
  ShowEntityInfo = false,
  ShowCollisionData = false,
  playerLoadPosition = {0,0,1}
}

Command = {
  -- here is where you can define shell command functions
  -- theyre formatted to take an array of arguments starting at index 2
  -- since it works by splitting the command into an array based on spaces,
  -- 'textbox say hello' in the terminal becomes: {'textbox', 'say', 'hello'}
  -- which then becomes: Command.textbox({'textbox', 'say', 'hello'})
  -- so basically reference your arguments starting at args[2]
  textbox = function(args)
    local _str = args[2]
    for index, value in ipairs(args) do
      if index > 2 then
        _str = _str .. " " .. value
      end
    end
    local _t = UI.Textbox({
      {text = _str}
    })
  end,
  inst = function(args)
    if args[2] == 'list' then
      Instance.list()
    end
  end,
  toggle = function(args)
    if     args[2] == 'boxes' then
      Debug.ShowBoxes = not Debug.ShowBoxes

    elseif args[2] == 'freecam' then
      Camera.mode = Camera.mode == view.player and view.free or view.player

    elseif args[2] == 'wireframe' then
      Debug.ShowWire = not Debug.ShowWire

    elseif args[2] == 'fs' then
      Game.Fullscreen = not Game.Fullscreen
      love.window.setFullscreen(Game.Fullscreen)
      local width, height, flags = love.window.getMode()
      Game.Resolution.width = width
      Game.Resolution.height = height
      WorldSurface[1]:release()
      WorldSurface = {
        love.graphics.newCanvas(
          width,
          height
        ),
        depth = true,
      }
      Shell.align()
    elseif args[2] == 'col' then
      Debug.ShowCollisionData = not Debug.ShowCollisionData
    end
  end,
  pos = function(args)
    if args[2] == 's' then
      Debug.playerLoadPosition = {Player.x, Player.y, Player.z}
      Shell.log('Player position saved at x:' .. Player.x .. ' y:' .. Player.y .. ' z:' .. Player.z)
    elseif args[2] == 'l' then
      Player.x,   Player.y,   Player.z,
      Player.hsp, Player.vsp, Player.zsp
      = Debug.playerLoadPosition[1],
        Debug.playerLoadPosition[2],
        Debug.playerLoadPosition[3],
        0,0,0
      Shell.log('loaded player position')
    end
  end
}