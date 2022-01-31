UI.Typography = function(x,y,str)
  local _t  = UI.Element(x,y)
  _t.name   = _t.name .. '-> Typography: "' .. str .. '"'
  _t.text   = love.graphics.newText(Font.default, str)
  _t.width  = _t.text:getWidth()
  _t.height = _t.text:getHeight()
  return _t
end