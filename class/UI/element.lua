UI = {}

UI.Element = function(x, y)
  local _u = Instance.create({
    name = 'UI Element',
    
    x = x,
    y = y,
    static = true,
    
    width = 16,
    height = 16,
    padding = 8
  }, StepOrder.UI, DrawOrder.UI)

  _u.drawBox = function()
    Color.set(Color.menuBack)
    love.graphics.rectangle('fill',_u.x,_u.y,_u.width,_u.height)
    Color.set(Color.menuOutline)
    love.graphics.rectangle('line',_u.x,_u.y,_u.width,_u.height)
  end

  _u.draw = function() end

  return _u
end