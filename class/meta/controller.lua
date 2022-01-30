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
    else
      Menu = UI.List(64,8,{
        {option = 'Hello',      callback = nil},
        {option = 'Pick',       callback = nil},
        {option = 'An',         callback = nil},
        {option = 'Option :)',  callback = nil},
      })
    end
  end
end