require "engine"
Game = {}

Game.Initialize = function()
  InitRooms()
  Player = NewPlayer()
  Room.load(Room.Test)
  Room.spawn(Player, 0,-4,0.85)
end

function InitRooms()
  require "game.room.arena"
  require "game.room.test"
end