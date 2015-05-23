require("lib")
local text = require("MainStory")

function level()
  local room = 0
  local chest,door,forest
  speak(text.intro00001)

  chest = function()
    speak(text.interactchest0001)
    character.inventory:add({name = "rags"})
    character.inventory:add({name = "sack"})
    character.inventory:add({name = "robe"})
    choice(door)
  end
  door = function()
    speak(text.interactdoor0001)
    forest()
  end
  forest = function()
    speak(text.intro00002)
  end

  choice(chest,door)

  error("end")
end

return coroutine.create(level)
