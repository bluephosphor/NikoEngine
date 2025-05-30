function ParticleEnvironment()
  local _p = Instance.create({
    types = {},
    parts = {},
    buffer = 5,
  },StepOrder.world, DrawOrder.world3D)

  _p.define = function(name, sprite, props)
    if not props.lifetime then return end

    local _tri = {
      { 1, 1,0,1,0},
      {-1,-1,0,0,1},
      { 1,-1,0,0,0}
    }

    local _t = props
    if not props.alphaSteps then
      _t.alphaSteps = {0,1,1,0}
    end
    _t.sprite = sprite
    _t.model = G3D.newModel(
      _tri,
      _t.sprite,
      {0,0,0},
      {math.pi/2,-1.56,0},
      _t.size and {1*_t.size,1*_t.size,1*_t.size} or {1,1,1}
    )
    _p.types[name] = _t
  end

  _p.emit = function(type, pos)
    local _t = _p.types[type]

    table.insert(_p.parts, {
      type          = _t,
      model         = _t.model,
      lifetime      = _t.lifetime,
      maxtime       = _t.lifetime,
      age           = 0,
      normalizedAge = 0,
      alpha         = 0,
      pos           = pos,
      speed         = _t.speed and {
        math.random() * _t.speed[1],
        math.random() * _t.speed[2],
        math.random() * _t.speed[3],
      } or nil
    })

  end

  _p.step = function(dt)
    local deleteIndicies = {}
    for i, part in ipairs(_p.parts) do
      part.age      = part.age + dt
      part.lifetime = part.lifetime - dt
      part.normalizedAge = part.age / part.maxtime * 1
      part.alpha = BlendNumbers(part.type.alphaSteps, part.maxtime, part.age)
      if part.type.speed then
        part.pos[1] = part.pos[1] + part.speed[1]
        part.pos[2] = part.pos[2] + part.speed[2]
        part.pos[3] = part.pos[3] + part.speed[3]
      end
      if part.lifetime <= 0 then
        table.insert(deleteIndicies, i)
      end
    end
    for _, i in ipairs(deleteIndicies) do
      table.remove(_p.parts, i)
    end
  end

  _p.render = function()
    for i, part in ipairs(_p.parts) do
      part.model:setTranslation(unpack(part.pos))
      if part.type.shader then
        part.type.shader:send('transparency', part.alpha)
        part.model:draw(part.type.shader)
      else
        part.model:draw()
      end
    end
  end

  return _p
end
