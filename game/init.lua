require "engine"
Game = {}

Game.Initialize = function()
  InitRooms()
  Player = NewPlayer()
  Room.load(Room.Arena)
  Room.spawn(Player, 0,-4,0.85)
end

function InitRooms()
  require "game.room.arena"
end