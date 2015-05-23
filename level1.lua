require("lib")
local text = require("MainStory")

speak = print

function level()
  local room = 0
  local chest,door,forest,pathway,lake
  speak(text.intro00001)

  chest = function()
    speak(text.interactchest0001)
    character.inventory:add({name = "Cloth Rags"})
    character.inventory:add({name = "Sack"})
    character.inventory:add({name = "Robe"})
    choiceDisplay = {"door"}
    choice(door)
  end

  door = function()
    speak(text.interactdoor0001)
    choiceDisplay = {"forest"}
    choice(forest)
  end

  forest = function()
    speak(text.intro00002)
    choiceDisplay = {"lake","pathway"}
    choice(lake,pathway)
    --status()
  end

  lake = function()
    speak(text.interactway0001)
    choiceDisplay = {"pathway"}
    choice(pathway)
  end

  pathway = function()
    speak(text.interactway0002)
    fight(bear)
  end

  choiceDisplay = {"chest","door"}
  --choice(chest,door)
  timedChoice(5,nil,chest,door)

  error("end")
end

return coroutine.create(level)
