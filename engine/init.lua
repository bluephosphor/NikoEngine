Engine = {
  State = "GAMEPLAY",
  Fullscreen = false,
  Resolution = {
    width  = 854,
    height = 480
  }
}

Engine.Initialize = function()
  require "engine.lib.core"
  require "engine.lib.math"
  require "engine.lib.color"
  require "engine.lib.definitions"

  require "engine.class.meta.controller"
  require "engine.class.meta.callstack"
  require "engine.class.meta.instance"
  require "engine.class.meta.sprite"
  require "engine.class.meta.debug"
  require "engine.class.meta.shell"

  require "engine.class.UI.element"
  require "engine.class.UI.typography"
  require "engine.class.UI.list"
  require "engine.class.UI.textbox"

  require "engine.class.world.room"
  require "engine.class.world.entity"
  require "engine.class.world.actor"
  require "engine.class.world.player"

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
  G3D = require('engine.g3d')
  require('engine.class.world.camera')
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