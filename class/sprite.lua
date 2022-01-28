require "lib.math"

function Sprite(path)
  local _s = {}
  _s.img = love.graphics.newImage(path)
  
  local _atlasHeight = _s.img:getHeight()
  local _atlasWidth  = _s.img:getWidth()
  local _atlasMargin = 1

  _s.totalFrames = floorToPrecision(_atlasWidth / (32 + _atlasMargin))
  _s.height = _atlasHeight - (_atlasMargin * 2)
  _s.width  = (_atlasWidth / _s.totalFrames) - (_atlasMargin * 2)

  _s.framedata = {}

  for i = 1, _s.totalFrames do
    local _atlasXIndex = (_s.width + _atlasMargin) * (i-1)
    _s.framedata[i] = love.graphics.newQuad(
      _atlasXIndex,
      _atlasMargin,
      _s.width,
      _s.height,
      _s.img:getDimensions()
    )
  end
  
  _s.frame = 1

  _s.draw = function(x, y, r, sx, sy)
    love.graphics.draw(_s.img, _s.framedata[_s.frame], x, y, r, sx, sy)
  end

  return _s
end