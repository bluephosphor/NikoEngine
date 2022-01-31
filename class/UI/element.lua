UI = {}

UI.Element = function(x, y, static)
  local _u = Instance.create({
    name = 'UI Element',
    
    x = x,
    y = y,
    static = static or true,
    
    width = 16,
    height = 16,
    padding = 8
  }, DrawOrder.UI)

  _u.drawBox = function()
    love.graphics.setColor(1,1,1,0.2)
    love.graphics.rectangle('fill',_u.x,_u.y,_u.width,_u.height)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('line',_u.x,_u.y,_u.width,_u.height)
  end

  return _u
end