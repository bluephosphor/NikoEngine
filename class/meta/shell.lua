InitShell = function()
  Shell = Instance.create({
    name        = '-> Shell',
    data        = {},
    anchor      = Direction.LEFT,
    width       = 300,
    height      = Game.Resolution.height,
    margin      = 8,
    padding     = 8,
    inputString = '',
    cursor      = '',
    blinkTimer  = 32,
    lineHeight  = 16,
  }, StepOrder.UI, DrawOrder.UI)

  -- initialize surface
  Shell.surface = love.graphics.newCanvas(Shell.width,Shell.height)
  love.graphics.setCanvas(Shell.surface)
  love.graphics.setCanvas()

  Shell.x = Game.Resolution.width - Shell.width
  Shell.y = 0
  Shell.origin = {
    x = Shell.margin + Shell.padding,
    y = Shell.height - Shell.lineHeight - Shell.margin
  }

  Shell.log = function(str)
    -- we draw a copy of our shell surface at an offset on a new temporary surface
    local _surfaceCopy = love.graphics.newCanvas(Shell.width, Shell.height)
    love.graphics.setCanvas(_surfaceCopy)
    love.graphics.draw(Shell.surface,0, -12)

    -- we then draw our new string to the bottom of this copy
    love.graphics.print(str, Shell.origin.x, Shell.origin.y)
    love.graphics.setCanvas()

    -- then we save the copy as our main surface
    Shell.surface = _surfaceCopy

    table.insert(Shell.data,str)
    print(str)
  end

  Shell.input = function(str)
    Shell.inputString = Shell.inputString .. str
  end

  Shell.call = function(str)
    local _data = strsplit(str)

    if pcall(function() Command[_data[1]](_data) end) then

    else
      Shell.log('error running command "' .. str .. '"')
    end
  end

  Shell.step = function()
    if Game.State == 'SHELL' then
      Shell.blinkTimer = wrap(Shell.blinkTimer - 1, 0, 32)
      Shell.cursor = Shell.blinkTimer < 16 and '|' or ''
      if Controller.key['return'] and Shell.inputString ~= '' then
        Shell.log('> ' .. Shell.inputString)
        Shell.call(Shell.inputString)
        Shell.inputString = ''
      end
      if Controller.key['backspace'] then
        Shell.inputString = string.sub(Shell.inputString, 1, string.len(Shell.inputString)-1)
      end
    else
      if Controller.key[Input.key.shell] then Game.State = 'SHELL' end
    end
  end

  Shell.draw = function()
    if Game.State ~= 'SHELL' then return end
    Color.set(Color.menuBack)
    love.graphics.rectangle(
      "fill",
      Shell.x + Shell.margin,
      Shell.y + Shell.margin,
      Shell.width - (Shell.margin*2),
      Shell.height - (Shell.margin*2)
    )
    Color.set(Color.menuOutline)
    love.graphics.rectangle(
      "line",
      Shell.x + Shell.margin,
      Shell.y + Shell.margin,
      Shell.width - (Shell.margin*2),
      Shell.height - (Shell.margin*2)
    )
    love.graphics.draw(Shell.surface, Shell.x, Shell.y - Shell.lineHeight)
    love.graphics.print(
      Shell.inputString .. Shell.cursor,
      Shell.x + Shell.origin.x,
      Shell.y + Shell.origin.y
    )
  end
end