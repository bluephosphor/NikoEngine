Input = {
  queue = {},
  key = {
    up      = "up",
    down    = "down",
    left    = "left",
    right   = "right",
    action  = "z",
    shell   = "/"
  },
}

Controller = {
  key = {},
  buffer = {},
  direction = {x = 0, y = 0}
}

Controller.getInputState = function()
  Controller.direction.x  = bin(love.keyboard.isDown(Input.key.right)) - bin(love.keyboard.isDown(Input.key.left))
  Controller.direction.y  = bin(love.keyboard.isDown(Input.key.down))  - bin(love.keyboard.isDown(Input.key.up))
  for index, value in ipairs(Input.queue) do
    Controller.key[value] = true
  end
end

Controller.reset = function()
  Controller.direction.x  = 0
  Controller.direction.y  = 0
  for button, value in pairs(Controller.key) do
    if Controller.key[button] then
      Controller.key[button] = false
    end
    if Controller.buffer[button] > 0 then
      Controller.buffer[button] = Controller.buffer[button] - 1
    end
  end
  Input.queue = {}
end

function love.keypressed(key, scancode, isrepeat)
  if Controller.buffer[key] == nil then
    Controller.buffer[key] = 0
  end
  if Controller.buffer[key] <= 0 then
    Controller.buffer[key] = 1
    table.insert(Input.queue, key)
  end
end

function love.textinput(char)
  if Game.State == "SHELL" then
    Shell.input(char)
  end
end