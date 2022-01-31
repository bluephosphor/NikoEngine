UI.List = function(x,y,data,options)
  local _l  = UI.Element(x,y)
  _l.name = _l.name .. "-> List"
  _l.data   = {}
  _l.index  = 1
  _l.inputbuffer = 1
  _l.size = table.maxn(data)
  _l.height = _l.padding * 2
  _l.width  = _l.padding * 2
  
  for i, v in ipairs(data) do
    local _item = UI.Typography(x,y,v.option)
    _item.x   = x + _l.padding
    _item.y   = y + _l.padding + (_item.height*(i-1))
    _l.height = _l.height + _item.height
    _l.width  = math.max(_l.width, _item.width + _l.padding * 2)
    
    _l.data[i]  = {option = _item, callback = v.callback}
    table.insert(_l.children, _item)
  end

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

    if Controller.key[Input.key.action] then
      if _l.data[_l.index].callback then 
        _l.data[_l.index].callback()
      end
      if options and options.destroyOnConfirm == true then
        Instance.destroy(_l)
      end
    end
  end

  _l.draw = function()
    _l.drawBox()
    for i, value in ipairs(_l.data) do
      if i == _l.index then love.graphics.setColor(1,0.5,0.8) end
      love.graphics.draw(value.option.text, value.option.x, value.option.y)
      love.graphics.setColor(1,1,1)
    end
  end

  return _l
end