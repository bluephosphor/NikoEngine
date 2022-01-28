require "lib.math"
require "class.actor"
require "class.sprite"

function NewPlayer(x,y)
  local _player = NewActor(x,y)
  local _step_inherited = _player.step
  _player.setSprite('asset/sprite/kitty.png')
  
  _player.step = function()
    _player.inf.x = bin(love.keyboard.isDown('right')) - bin(love.keyboard.isDown('left'))
    _player.inf.y = bin(love.keyboard.isDown('down'))  - bin(love.keyboard.isDown('up'))

    if _player.facing == -_player.inf.x then
      _player.facing = _player.inf.x
    end
    
    _step_inherited()
  end

  return _player
end