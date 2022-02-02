function Sprite(path, frameWidth)
  local _s = {
    img        = love.graphics.newImage(path),
    framedata  = {},
    frame      = 1,
    frameWidth = frameWidth and frameWidth or 32,
    animation  = {
      frames  = {},
      index   = 1,
      timer   = 4,
      speed   = 4,
      length  = nil
    }
  }

  local _atlasHeight = _s.img:getHeight()
  local _atlasWidth  = _s.img:getWidth()
  local _atlasMargin = 1

  _s.totalFrames  = math.floor(_atlasWidth / (frameWidth + _atlasMargin))
  _s.height       = _atlasHeight - (_atlasMargin * 2)
  _s.width        = (_atlasWidth / _s.totalFrames) - (_atlasMargin * 2)

  --initialize framedata and default animation
  for i = 1, _s.totalFrames do
    local _atlasXIndex = (_s.width + (_atlasMargin * 2)) * (i-1)
    _s.framedata[i] = love.graphics.newQuad(
      _atlasXIndex,
      _atlasMargin,
      _s.width,
      _s.height,
      _s.img:getDimensions()
    )
    _s.animation.frames[i] = i
  end

  _s.setAnimation = function(anim)
    _s.animation.frames = anim.frames
    _s.animation.index = 1
    _s.animation.timer = 1
    for index, value in ipairs(anim.frames) do
      _s.animation.frames[index] = value
      _s.animation.length = index
    end
    _s.frame = anim.frames[1]
  end

  _s.animate = function()
    if _s.animation.length == nil then return end

    _s.animation.timer = _s.animation.timer - 1
    if _s.animation.timer > 0 then
      return
    else
      _s.animation.index = _s.animation.index + 1
      if _s.animation.index > _s.animation.length then
        _s.animation.index = 1
      end
      _s.frame = _s.animation.frames[_s.animation.index]
      _s.animation.timer = _s.animation.speed
    end
  end

  _s.draw = function(x, y, r, sx, sy)
    love.graphics.draw(_s.img, _s.framedata[_s.frame], x, y, r, sx, sy)
  end

  return _s
end