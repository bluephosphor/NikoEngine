UI.Textbox = function(data, x, y)
  local _t    = UI.Element(x,y)
  _t.name     = '-> Textbox'
  _t.data     = {}
  _t.index    = 1
  _t.length   = 0;
  _t.size     = table.maxn(data)
  _t.finished = false

  for index, value in ipairs(data) do
    local _item = UI.Typography(x,y, value.text)
    _item.text:set('')
    _t.data[index]  = _item
    _t.length       = index
    _t.width        = math.max(_t.width,  _item.width  + (_t.padding * 2))
    _t.height       = math.max(_t.height, _item.height + (_t.padding * 2))
    table.insert(_t.children, _item)
  end

  if not x then _t.x = Game.Resolution.width/2 - _t.width/2 end
  if not y then _t.y = Game.Resolution.height/2 - _t.height/2 end


  _t.step = function()
    _t.finished = _t.data[_t.index].typewriter()
    if _t.finished then
      _t.index = _t.navigate(_t.index, clamp)
    end
  end

  _t.draw = function()
    _t.drawBox()
    love.graphics.draw(
      _t.data[_t.index].text,
      _t.x + _t.padding, _t.y + _t.padding
    )
  end

  return _t
end