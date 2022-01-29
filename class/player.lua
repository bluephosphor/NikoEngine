require "lib.math"
require "class.actor"
require "class.sprite"

function NewPlayer(x,y)
  local _player = NewActor(x,y)
  local _step_inherited = _player.step
  _player.setSprite('asset/sprite/kitty.png',{
    idle = {1,2,3,4,5,6,7},
    walk = {8,9,10,11}
  })
  
  _player.step = function()
    _player.inf.x = bin(love.keyboard.isDown('right')) - bin(love.keyboard.isDown('left'))
    _player.inf.y = bin(love.keyboard.isDown('down'))  - bin(love.keyboard.isDown('up'))

    if _player.inf.x ~= 0 and _player.inf.y ~= 0 then
      _player.sprite.setAnimation(_player.sprite.animation.walk)
    else
      _player.sprite.setAnimation(_player.sprite.animation.idle)
    end

    if _player.facing == -_player.inf.x then
      _player.facing = _player.inf.x
    end
    
    _step_inherited()
  end

  return _player
end