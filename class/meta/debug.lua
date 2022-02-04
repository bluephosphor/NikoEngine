Debug = {
  menu = nil,
  ShowBoxes = false,
  ShowEntityInfo = false
}

Command = {
  -- here is where you can define shell command functions
  -- theyre formatted to take an array of arguments starting at index 2
  -- since it works by splitting the command into an array based on spaces,
  -- 'command with arguments' in the terminal becomes: {'command, 'with', 'arguments'}
  -- which then becomes: command({with, arguments})
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
  end
}