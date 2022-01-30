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
    main        = CallStack('draw'),
    UI          = CallStack('draw')
  }
end

Game.Loop = function()
  if not Game.Paused then StepOrder.eval() end
end

Game.Render = function()
  DrawOrder.background.eval()
  DrawOrder.main.eval()
  DrawOrder.UI.eval()
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

  _c.remove = function(who)
    for index, value in ipairs(_c.list) do
      if value == who.id then
        table.remove(_c.list, index)
      end
    end
  end

  _c.eval = function()
  
    for index, value in ipairs(_c.list) do
      local _inst = Instance.lookupTable[value]
      _inst[type]()
    end
  
  end
  
  return _c
end