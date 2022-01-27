function Entity(x,y)
  local _entity = {
    x = x,
    y = y,
    width = 32,
    height = 32,

    hsp = 0,
    vsp = 0,

    inf = {x = 0, y = 0}
  }
  _entity.step = function()
    _entity.x = _entity.x + _entity.hsp
    _entity.y = _entity.y + _entity.vsp
  end

  _entity.draw = function()
    love.graphics.rectangle('fill',_entity._entity.x,_entity.y,_entity.width,_entity.height)
  end

  return _entity
end