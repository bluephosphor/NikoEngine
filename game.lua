require "class.meta.controller"

Game = {
  Paused      = false,
  Debug       = true,
  ShowBoxes   = false,
  Resolution  = {
    width   = 854,
    height  = 480
  }
}

Game.Initialize = function()
  InitWindow()
  InitFonts()

  StepOrder = CallStack('step')
  DrawOrder = {
    background  = CallStack('draw'),
    world       = CallStack('draw'),
    UI          = CallStack('draw')
  }
end

function InitWindow()
  love.graphics.setDefaultFilter("nearest", "nearest", 0);
  love.graphics.setBackgroundColor(0.3,0.5,0.3)
  love.window.setMode(
    Game.Resolution.width,
    Game.Resolution.height,
    {
      highdpi = true,
    --usedpiscale = false
    }
  )
end

function InitFonts()
  Font = {}
  Font.default = love.graphics.newImageFont(
    "asset/spriteFont/1.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\""
  )
  love.graphics.setFont(Font.default)
end

function CallStack(type)
  local _c = {
    list = {},
    idcounter = 0
  }

  _c.add = function(who)
    table.insert(_c.list, who.id)
  end

  _c.remove = function(id)
    for index, value in ipairs(_c.list) do
      if value == id then
        table.remove(_c.list, index)
        return true
      end
    end
    return false
  end

  _c.eval = function()
    for index, value in ipairs(_c.list) do
      local _inst = Instance.lookupTable[value]
      if _inst then _inst[type]() end
    end
  end
  
  return _c
end