function ParticleEnvironment()
  local _p = Instance.create({
    types = {},
    parts = {},
  },StepOrder.world, DrawOrder.world3D)

  _p.define = function(name, sprite, props)
    if not props.lifetime then return end

    local _t = props
    _t.sprite = sprite

    _p.types[name] = _t
  end

  _p.emit = function(type, pos)
    local _tri = {
      { 1, 1,0,1,0},
      {-1,-1,0,0,1},
      { 1,-1,0,0,0}
    }
    local _t = _p.types[type]
    local _i = G3D.newModel(_tri,_t.sprite,pos,{math.pi/2,-1.56,0})
    _i.lifetime = _t.lifetime
    table.insert(_p.parts, _i)
  end

  _p.step = function()
    local deleteIndicies = {}
    for i, part in ipairs(_p.parts) do
      part.lifetime = part.lifetime - 1
      if part.lifetime <= 0 then
        table.insert(deleteIndicies, i)
      end
    end
    for _, i in ipairs(deleteIndicies) do
      table.remove(_p.parts, i)
    end
  end

  _p.draw = function()
    for i, part in ipairs(_p.parts) do
      part:draw()
    end
  end

  return _p
end
