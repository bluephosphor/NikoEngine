Engine = {
  State = "GAMEPLAY",
  Fullscreen = false,
  Resolution = {
    width  = 854,
    height = 480
  }
}

Engine.Initialize = function()
  require "lib.core"
  require "lib.math"
  require "lib.color"
  require "lib.definitions"

  require "class.meta.controller"
  require "class.meta.callstack"
  require "class.meta.instance"
  require "class.meta.sprite"
  require "class.meta.debug"
  require "class.meta.shell"

  require "class.UI.element"
  require "class.UI.typography"
  require "class.UI.list"
  require "class.UI.textbox"

  require "class.world.room"
  require "class.world.entity"
  require "class.world.actor"
  require "class.world.player"

  InitWindow()
  InitFonts()
  Init3D()
  InitEventOrder()
  InitShell()
end

Engine.Update = function(dt)
  Camera.update(dt)
  if Controller.key['escape'] then
    if Shell.open then
      Shell.open = false
      return
    end
    if Engine.State ~= "GAMEPLAY" then
      Engine.State = 'GAMEPLAY'
      return
    end
    if Camera.mode == view.free then
      Camera.mode = view.player
      return
    end
    love.event.push "quit"
  end
end

function InitWindow()
  love.graphics.setDefaultFilter("nearest", "nearest", 0);
  love.graphics.setBackgroundColor(0.3,0.2,0.5)
  love.window.setMode(
    Engine.Resolution.width,
    Engine.Resolution.height,
    {
      highdpi = true,
    --usedpiscale = false
    }
  )
end

function Init3D()
  G3D = require('g3d')
  require('class.world.camera')
  WorldSurface = {
    love.graphics.newCanvas(
      Engine.Resolution.width,
      Engine.Resolution.height
    ),
    depth = true,
  }
end

function Render3D()
  love.graphics.setCanvas(WorldSurface)
  love.graphics.clear()
  DrawOrder.world3D.eval()
  love.graphics.setWireframe(Debug.ShowWire)
  if Room.current then
    Room.current.draw()
  end
  love.graphics.setWireframe(false)
  love.graphics.setCanvas()
  love.graphics.draw(WorldSurface[1])
end

function InitFonts()
  Font = {}
  Font.default = love.graphics.newImageFont(
    "asset/spriteFont/1.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\""
  )
  Font.terminal = love.graphics.newFont("asset/font/softsquare.fnt")
  love.graphics.setFont(Font.terminal)
end

function InitEventOrder()
  StepOrder = {
    world = CallStack('step'),
    UI    = CallStack('step')
  }
  DrawOrder = {
    background  = CallStack('draw'),
    world3D     = CallStack('draw'),
    world       = CallStack('draw'),
    UI          = CallStack('draw')
  }
end