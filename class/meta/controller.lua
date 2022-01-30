Controller = {
  action = false,
  direction = {x = 0, y = 0}
}

Controller.getInputs = function()
  Controller.direction.x  = bin(love.keyboard.isDown('right')) - bin(love.keyboard.isDown('left'))
  Controller.direction.y  = bin(love.keyboard.isDown('down'))  - bin(love.keyboard.isDown('up'))
  Controller.action       = love.keyboard.isDown('x')
end

Controller.reset = function()
  Controller.direction.x  = 0
  Controller.direction.y  = 0
  Controller.action       = false
end

function love.keypressed(key, scancode, isrepeat)
  if key == "k" then
    if Instance.exists(Menu) then
      Instance.destroy(Menu.id)
      love.graphics.setBackgroundColor(0,0,0)
    elseif Menu == nil then
      Menu = UI.List(64,8,{
        {option = 'Help',      callback = nil},
        {option = 'why',       callback = nil},
        {option = 'is',         callback = nil},
        {option = 'this',  callback = nil},
        {option = 'happening',  callback = nil},
      })
    end
  end
end