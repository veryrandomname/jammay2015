function run(f)
  local timer = 0
  local coStatus, choiceRange, maxtime = coroutine.resume(f)
  if not coStatus then error(choiceRange) end

  return function(dt, input)
    timer = timer + dt

    if timer > maxtime or (input and input > 0 and input <= choiceRange) then
      coStatus, choiceRange,maxtime = coroutine.resume(f, timer, input)
      if not coStatus then error(choiceRange) end
      timer = 0
    end
  end
end

local game = run(require('level1'))
local lastbutton

function love.update(dt)
  game(dt, lastbutton)
  lastbutton = nil
end

function love.joystickpressed(joystick, button)
  lastbutton = button
end
