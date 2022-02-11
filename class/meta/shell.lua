InitShell = function()
  Shell = Instance.create({
    name        = '-> Shell',
    open        = false,
    data        = {},
    anchor      = Direction.LEFT,
    width       = 300,
    height      = Game.Resolution.height,
    margin      = 8,
    padding     = 8,
    inputString = '',
    cursor      = '',
    blinkTimer  = 32,
    logBuffer   = 0,
    lineHeight  = 16,
  }, StepOrder.UI, DrawOrder.UI)

  -- initialize surfaces
  Shell.surface  = love.graphics.newCanvas(Shell.width,Shell.height)
  Shell.surface2 = love.graphics.newCanvas(Shell.width, Shell.height)

  Shell.align = function()
    Shell.x = Game.Resolution.width - Shell.width
    Shell.y = 0
    Shell.origin = {
      x = Shell.margin + Shell.padding,
      y = Shell.height - Shell.lineHeight - Shell.margin
    }
  end
  Shell.align()

  Shell.log = function(str)
    if Shell.logBuffer > 0 then return end

    -- we draw a copy of our shell surface at an offset on the secondary surface
    love.graphics.setCanvas(Shell.surface2)
    love.graphics.clear()
    love.graphics.draw(Shell.surface,0, -12)

    -- we then draw our new string to the bottom of this copy
    love.graphics.print(str, Shell.origin.x, Shell.origin.y)

    -- then we draw the copy on our main surface
    love.graphics.setCanvas(Shell.surface)
    love.graphics.clear()
    love.graphics.draw(Shell.surface2,0, 0)

    love.graphics.setCanvas()
    table.insert(Shell.data,str)
    --print(str)
  end

  Shell.clear = function ()
    if Shell.logBuffer > 0 then return end
    local _surf = love.graphics.getCanvas()
    love.graphics.setCanvas(Shell.surface)
    love.graphics.clear()
    love.graphics.setCanvas(_surf)
    Shell.data  = {}
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
    Shell.logBuffer = approach(Shell.logBuffer, 0, 1)
    if Shell.open then
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
      if Controller.key[Input.key.shell] then Shell.open = true end
    end
  end

  Shell.draw = function()
    if not Shell.open then return end
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