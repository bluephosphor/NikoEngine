require "class.UI.element"
require "class.meta.controller"
require "lib.core"

UI.List = function(x,y,data)
  local _l  = UI.Element(x,y)
  _l.data   = data
  _l.index  = 1
  _l.inputbuffer = 1
  _l.size = table.maxn(data)
  _l.lineHeight = 16
  _l.height = (_l.lineHeight * _l.size) + (_l.padding * 2)
  _l.width = 200 + (_l.padding * 2)

  _l.step = function()
    if Controller.direction.y ~= 0 then
      if _l.inputbuffer <= 0 then
        _l.index = wrap(_l.index + Controller.direction.y, 1, _l.size)
        _l.inputbuffer = 10
      else
        _l.inputbuffer = _l.inputbuffer - 1
      end
    else
      _l.inputbuffer = 1
    end
  end

  _l.draw = function()
    _l.drawBox()
    for i, value in ipairs(_l.data) do
      if i == _l.index then love.graphics.setColor(1,0,0) end
      love.graphics.print(value.option, _l.x + _l.padding, _l.y + _l.padding + (_l.lineHeight*(i-1)))
      love.graphics.setColor(1,1,1)
    end
  end
end