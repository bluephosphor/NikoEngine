require "actor"

function love.load()
 Text = 'hello'
 Player = Actor(300,300)
 Player.step = function()
  
 end
end

function love.update()

end

function love.draw()
  love.graphics.print(Text,122,222)
  Player.draw()
end

