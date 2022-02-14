require "engine"
Game = {}

Game.Initialize = function()
  InitRooms()
  InitBGs()
  Player = NewPlayer()
  Room.load(Room.Test)
  Room.spawn(Player, 0,15,0.85)
end

function InitRooms()
  require "game.room.arena"
  require "game.room.test"
end

function InitBGs()
  require "game.background"
  local _path = '/asset/sprite/blobs/'
  Blob = {
    clouds = Sprite(_path .. 'clouds.png', 64)
  }

  Background.Sky(Blob.clouds, 400, {
    Color.get('dkgray', 0.5),
    Color.get('dkpurple', 0.8),
    Color.get('blue', 0.5),
    Color.get('red',0.7),
    Color.get('white', 0.5),
    Color.get('white')
  })
end