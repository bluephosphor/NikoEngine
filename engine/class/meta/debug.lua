Debug = {
  menu = nil,
  ShowBoxes = false,
  ShowWire = false,
  ShowEntityInfo = false,
  ShowCollisionData = false,
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

    elseif args[2] == 'fc' then
      Camera.mode = Camera.mode == view.player and view.free or view.player

    elseif args[2] == 'wire' then
      Debug.ShowWire = not Debug.ShowWire

    elseif args[2] == 'fs' then
      Engine.Fullscreen = not Engine.Fullscreen
      love.window.setFullscreen(Engine.Fullscreen)
      local width, height, flags = love.window.getMode()
      Engine.Resolution.width  = width
      Engine.Resolution.height = height
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
      Player.loadPosition = {Player.x, Player.y, Player.z}
      Shell.log('Player position saved at x:' .. Player.x .. ' y:' .. Player.y .. ' z:' .. Player.z)
    elseif args[2] == 'l' then
      Player.x,   Player.y,   Player.z,
      Player.hsp, Player.vsp, Player.zsp
      = Player.loadPosition[1],
        Player.loadPosition[2],
        Player.loadPosition[3],
        0,0,0
      Shell.log('loaded player position')
    end
  end
}

function love.resize(w, h)
  -- for when toggle fs changes the aspect
  G3D.camera.aspectRatio = w / h
  G3D.camera.updateProjectionMatrix()
  Background.Rerender()
end