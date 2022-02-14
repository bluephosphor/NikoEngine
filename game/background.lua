Background = {
  surface = love.graphics.newCanvas(Engine.Resolution.width, Engine.Resolution.height),
  current = nil
}

Background.Sky = function(sprite, amt, colors)
  local _surf = love.graphics.getCanvas()
  love.graphics.setCanvas(Background.surface)
  love.graphics.clear(unpack(colors[1]))
  local _w, _h = Engine.Resolution.width, Engine.Resolution.height

  for i = 1, amt, 1 do
    local _c = Background.BlendColors(colors,amt,i)

    local _len = #sprite.framedata
    local _frame = clamp(math.ceil(i / amt * _len), 1, _len)

    love.graphics.setColor(unpack(_c))
    love.graphics.draw(
      sprite.img,
      sprite.framedata[_frame],
      love.math.random(_w) - sprite.width,
      love.math.random(_h) - sprite.height,
      0,
      2,2
    )
  end
  Color.reset()
  love.graphics.setCanvas(_surf)
  Background.lastSettings = {sprite,amt,colors}
end


Background.BlendColors = function(colors, steps, i)
  local cc = i / steps * #colors
  local c1 = colors[math.max(math.floor(cc), 1)]
  local c2 = colors[math.ceil(cc)]

  return merge_color(c1,c2, cc - math.max(math.floor(cc), 1))
end

Background.draw = function()
  love.graphics.draw(Background.surface)
end

Background.Rerender = function()
  Background.surface:release()
  Background.surface = love.graphics.newCanvas(Engine.Resolution.width, Engine.Resolution.height)
  Background.current(unpack(Background.lastSettings))
end