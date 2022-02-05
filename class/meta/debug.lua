Debug = {
  menu = nil,
  ShowBoxes = false,
  ShowEntityInfo = false
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
    if args[2] == 'boxes' then
      Debug.ShowBoxes = not Debug.ShowBoxes
    elseif args[2] == 'freecam' then
      Camera.mode = Camera.mode == view.player and view.free or view.player
    end
  end,
}