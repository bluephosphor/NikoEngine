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
  require "engine.lib.gameplay"

  require "engine.class.meta.controller"
  require "engine.class.meta.callstack"
  require "engine.class.meta.instance"
  require "engine.class.meta.sprite"
  require "engine.class.meta.debug"
  require "engine.class.meta.shell"
  require "engine.class.meta.particle"

  require "engine.class.UI.element"
  require "engine.class.UI.typography"
  require "engine.class.UI.list"
  require "engine.class.UI.textbox"

  require "engine.class.world.room"
  require "engine.class.world.object"
  require "engine.class.world.entity"
  require "engine.class.world.actor"

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

Engine.draw = function()
  DrawOrder.world.eval()
  Render3D()
  DrawOrder.UI.eval()
  Controller.reset()
  Color.set('black', 0.8)
  love.graphics.rectangle("fill",0,0,100,48)
  Color.reset()
  love.graphics.print('fps: ' .. love.timer.getFPS())
  love.graphics.print('delta: ' .. floorToPrecision(love.timer.getDelta(),4), 0, 8)
  love.graphics.print('stepTime: ' .. floorToPrecision(love.timer.step(),4), 0, 16)
  love.graphics.print(Player.inWater and 'inWater: true' or 'inWater: false',0, 24)
  love.graphics.print(
    Player.x and
    'x: '  .. floorToPrecision(Player.x, 2) ..
    ' y: ' .. floorToPrecision(Player.y, 2) ..
    ' z: ' .. floorToPrecision(Player.z, 2), 0, 32
  )
end

function InitWindow()
  love.graphics.setDefaultFilter("nearest", "nearest", 0);
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
    Particles.render()
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