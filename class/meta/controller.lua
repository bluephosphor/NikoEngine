Input = {
  queue = {},
  key = {
    up      = "up",
    down    = "down",
    left    = "left",
    right   = "right",
    action  = "z"
  },
}

Controller = {
  key = {},
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
    Controller.key[button] = false
  end
  Input.queue = {}
end

function love.keypressed(key, scancode, isrepeat)
  table.insert(Input.queue, key)
  print(key .. ' inserted into input queue')
  print('queue size: ' .. table.maxn(Input.queue))
end