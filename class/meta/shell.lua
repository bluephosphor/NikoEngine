InitShell = function()
  Shell = Instance.create({
    name = '-> Shell',
    data = {},
    anchor = Direction.LEFT,
    width = 300,
    height = Game.Resolution.height,
    padding = 8,
    maxDrawLines = 100,
    drawCount = 0,
    visible = true,
  }, StepOrder.UI, DrawOrder.UI)

  Shell.surface = love.graphics.newCanvas(Shell.width,Shell.height)
  love.graphics.setCanvas(Shell.surface)
  love.graphics.clear(Color.black)
  love.graphics.setCanvas()

  Shell.x = Game.Resolution.width - Shell.width
  Shell.y = 0
  Shell.origin = {
    x = Shell.x + Shell.padding,
    y = Shell.y + Shell.height - (Shell.padding * 2)
  }

  Shell.log = function(str)
    table.insert(Shell.data,str)
    local _surfaceCopy = love.graphics.newCanvas(Shell.width, Shell.height)
    love.graphics.setCanvas(_surfaceCopy)
    love.graphics.draw(Shell.surface,0, -12)
    love.graphics.print(str, Shell.padding, Shell.height - Shell.padding*2)
    love.graphics.setCanvas()
    Shell.surface = _surfaceCopy
    print(str)
  end

  Shell.step = function()
    Shell.drawCount = math.min(table.maxn(Shell.data),Shell.maxDrawLines);
  end

  Shell.draw = function()
    local draw_y = Shell.origin.y
    Color.set(Color.black)
    love.graphics.rectangle("fill", Shell.x, Shell.y, Shell.width, Shell.height)
    Color.set(Color.white)
    love.graphics.rectangle("line", Shell.x, Shell.y, Shell.width, Shell.height)
    love.graphics.draw(Shell.surface, Shell.x, Shell.y)
  end
end