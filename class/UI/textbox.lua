UI.Textbox = function(data, x, y)
  Engine.State = 'DIALOGUE'

  local _t    = UI.Element(x,y)
  _t.name     = '-> Textbox'
  _t.data     = {}
  _t.index    = 1
  _t.length   = 0
  _t.size     = table.maxn(data)
  _t.finished = false

  _t.nextSprite = Sprite('asset/sprite/pagemarker.png', 16)

  _t.nextSprite.defineAnimation('nextPage', {
    frames = range(1,7),
    speed = 4
  })

  _t.nextSprite.defineAnimation('lastPage', {
    frames = range(8,14),
    speed = 6
  })

  for index, value in ipairs(data) do
    local _item = UI.Typography(x,y, value.text)  
    _item.text:set('')
    _t.data[index]  = _item
    _t.length       = index
    _t.width        = math.max(_t.width,  _item.width  + (_t.padding * 2))
    _t.height       = math.max(_t.height, _item.height + (_t.padding * 2))
    table.insert(_t.children, _item)
  end

  if not x then _t.x = Engine.Resolution.width/2  - _t.width/2 end
  if not y then _t.y = Engine.Resolution.height/2 - _t.height/2 end

  _t.step = function()
    _t.nextSprite.visible = false
    _t.finished = _t.data[_t.index]:typewriter()
    if _t.finished then
      _t.nextSprite.visible = true
      _t.nextSprite.animate()

      _t.index = _t.index + bin(Controller.key[Input.key.action])
      if _t.index > _t.size then
        Instance.destroy(_t)
        return
      end

      _t.index = _t.navigate(_t.index, clamp)
      if _t.index == _t.size then
        _t.nextSprite.setAnimation(_t.nextSprite.animations.lastPage)
      else
        _t.nextSprite.setAnimation(_t.nextSprite.animations.nextPage)
      end
    end
  end

  _t.draw = function()
    _t:drawBox()
    _t.nextSprite.draw(
      _t.x + (_t.width/2) - (_t.nextSprite.width/2),
      _t.y +_t.height + 2
    )
    love.graphics.draw(
      _t.data[_t.index].text,
      _t.x + _t.padding, _t.y + _t.padding
    )
  end

  _t.preDestroy = function()
    _t.nextSprite:free()
    Engine.State = 'GAMEPLAY'
  end

  return _t
end