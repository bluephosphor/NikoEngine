Game = {
  Paused      = false,
  Debug       = false,
  Resolution  = {
    width   = 854,
    height  = 480
  }
}

Game.Initialize = function()
  require "lib.core"
  require "lib.math"
  
  require "class.meta.controller"
  require "class.meta.callstack"
  require "class.meta.instance"
  require "class.meta.sprite"
  require "class.meta.debug"

  require "class.UI.element"
  require "class.UI.typography"
  require "class.UI.list"

  require "class.world.entity"
  require "class.world.actor"
  require "class.world.player"

  InitWindow()
  InitFonts()
  InitEventOrder()
end

function InitWindow()
  love.graphics.setDefaultFilter("nearest", "nearest", 0);
  love.graphics.setBackgroundColor(0.5,1,1)
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

function InitEventOrder()
  StepOrder = CallStack('step')
  DrawOrder = {
    background  = CallStack('draw'),
    world       = CallStack('draw'),
    UI          = CallStack('draw')
  }
end