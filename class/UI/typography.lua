UI.Typography = function(x,y,str)
  local _t  = UI.Element(x,y)
  _t.name   = _t.name .. '-> Typography: "' .. str .. '"'
  _t.str    = str --stringwrap method will go here
  _t.text   = love.graphics.newText(Font.default, _t.str)
  _t.width  = _t.text:getWidth()
  _t.height = _t.text:getHeight()
  _t.len    = string.len(str)
  _t.index  = 1

  _t.typewriter = function()
    if _t.index > _t.len then return true end

    _t.text:set(string.sub(_t.str,1, _t.index))
    _t.index = _t.index + 1
    return false
  end
  return _t
end