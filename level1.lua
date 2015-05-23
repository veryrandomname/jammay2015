require("lib")
local text = require("MainStory")

speak = print

function level()
  local room = 0
  local chest,door,forest
  speak(text.intro00001)

  chest = function()
    speak(text.interactchest0001)
    character.inventory:add({name = "rags"})
    character.inventory:add({name = "sack"})
    character.inventory:add({name = "robe"})
    choiceDisplay = {"door"}
    choice(door)
  end
  door = function()
    speak(text.interactdoor0001)
    forest()
  end
  forest = function()
    speak(text.intro00002)
    --status()
  end

  choiceDisplay = {"chest","door"}
  --choice(chest,door)
  timedChoice(5,nil,chest,door)

  error("end")
end

return coroutine.create(level)
