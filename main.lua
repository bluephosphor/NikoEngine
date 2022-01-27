require "player"

function love.load()
  Player = NewPlayer(300,300)
end

function love.update()
  Player.step()
end

function love.draw()
  Player.draw()
  DrawEntityVars(Player)
end


function DrawEntityVars(e)
  local _y = 0;
  love.graphics.print('hsp:   ' .. e.hsp,0,_y);       _y = _y + 12
  love.graphics.print('vsp:   ' .. e.vsp,0,_y);       _y = _y + 12
  love.graphics.print('inf.x: ' .. e.inf.x,0,_y);     _y = _y + 12
  love.graphics.print('inf.y: ' .. e.inf.y,0,_y);     _y = _y + 24
  
  love.graphics.print('direction(degrees): ' .. e.direction,0,_y); _y = _y + 12
  love.graphics.print('direction(radians): ' .. e.dirRad,0,_y); _y = _y + 12
  love.graphics.print('vector distance: '   .. e.distance,0,_y); _y = _y + 12
end
