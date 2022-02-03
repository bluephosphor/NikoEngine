InitShell = function()
  Shell = Instance.create({
    name = '-> Shell',
    data = {},
    anchor = Direction.LEFT,
    width = 300,
    height = Game.Resolution.height,
    padding = 8,
    inputString = '',
    cursor = '',
    blinkTimer = 32,
    lineHeight = 16,
  }, StepOrder.UI, DrawOrder.UI)

  Shell.surface = love.graphics.newCanvas(Shell.width,Shell.height)
  love.graphics.setCanvas(Shell.surface)
  --love.graphics.clear()
  love.graphics.setCanvas()

  Shell.x = Game.Resolution.width - Shell.width
  Shell.y = 0
  Shell.origin = {
    x = Shell.padding,
    y = Shell.height - Shell.lineHeight
  }

  Shell.log = function(str)
    local _surfaceCopy = love.graphics.newCanvas(Shell.width, Shell.height)
    love.graphics.setCanvas(_surfaceCopy)
    love.graphics.draw(Shell.surface,0, -12)
    love.graphics.print(str, Shell.origin.x, Shell.origin.y)
    love.graphics.setCanvas()
    Shell.surface = _surfaceCopy

    table.insert(Shell.data,str)
    print(str)
  end

  Shell.input = function(str)
    Shell.inputString = Shell.inputString .. str
  end

  Shell.step = function()
    if GlobalState == State.SHELL then
      Shell.blinkTimer = wrap(Shell.blinkTimer - 1, 0, 32)
      Shell.cursor = Shell.blinkTimer < 16 and '|' or ''
      if Controller.key['escape'] then
        GlobalState = State.GAME
      end
      if Controller.key['return'] then
        Shell.log('> ' .. Shell.inputString)
        Shell.inputString = ''
      end
      if Controller.key['backspace'] then
        Shell.inputString = string.sub(Shell.inputString, 1, string.len(Shell.inputString)-1)
      end
    else
      if Controller.key[Input.key.shell] then GlobalState = State.SHELL end
    end
  end

  Shell.draw = function()
    if GlobalState ~= State.SHELL then return end
    Color.set(Color.black)
    love.graphics.rectangle("fill", Shell.x, Shell.y, Shell.width, Shell.height)
    Color.set(Color.white)
    love.graphics.rectangle("line", Shell.x, Shell.y, Shell.width, Shell.height)
    love.graphics.draw(Shell.surface, Shell.x, Shell.y - Shell.lineHeight)
    love.graphics.print(
      Shell.inputString .. Shell.cursor,
      Shell.x + Shell.origin.x,
      Shell.y + Shell.origin.y
    )
  end
end