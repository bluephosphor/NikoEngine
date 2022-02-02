UI = {}

UI.Element = function(x, y)
  local _u = Instance.create({
    name = 'UI Element',

    x = x and x or 0,
    y = y and y or 0,
    static = true,
    inputbuffer = 1,

    width = 16,
    height = 16,
    size = 0,
    padding = 8
  }, StepOrder.UI, DrawOrder.UI)

  _u.drawBox = function()
    Color.set(Color.menuBack)
    love.graphics.rectangle('fill',_u.x,_u.y,_u.width,_u.height)
    Color.set(Color.menuOutline)
    love.graphics.rectangle('line',_u.x,_u.y,_u.width,_u.height)
  end

  _u.navigate = function(value, method)
    if Controller.direction.y ~= 0 then
      if _u.inputbuffer <= 0 then
        value = method(value + Controller.direction.y, 1, _u.size)
        _u.inputbuffer = 10
      else
        _u.inputbuffer = _u.inputbuffer - 1
      end
    else
      _u.inputbuffer = 1
    end
    return value
  end

  _u.draw = function() end

  return _u
end