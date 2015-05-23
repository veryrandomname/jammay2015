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
    
    return timer,maxtime
  end
end

local game = run(require('level1'))
local lastbutton
local timer,maxtime

function love.load()
  width, height = love.graphics.getDimensions( )

  cx,cy,cd = width*0.45, height*0.45, height*0.2

  love.graphics.setBackgroundColor(23,46,58)

  love.graphics.setFont( love.graphics.newFont( "GlacialIndifference-Regular.otf", 66 ) )
end

function love.update(dt)
  timer,maxtime = game(dt, lastbutton)
  lastbutton = nil
end

function love.joystickpressed(joystick, button)
  lastbutton = button
end

function love.keypressed( key, isrepeat )
  if key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.setColor(100,255,100)
  if choiceDisplay[1] then
    love.graphics.print("A " .. choiceDisplay[1], cx , cy+cd) 
  else
    love.graphics.print("A", cx , cy+cd) 
  end
  love.graphics.setColor(255,100,100)
  if choiceDisplay[2] then
    love.graphics.print("B " .. choiceDisplay[2], cx+cd, cy) 
  else
    love.graphics.print("B", cx+cd, cy) 
  end
  love.graphics.setColor(100,100,255)
  if choiceDisplay[3] then
    love.graphics.print("X " .. choiceDisplay[3], cx-cd, cy) 
  else
    love.graphics.print("X", cx-cd, cy) 
  end
  love.graphics.setColor(200,200,000)
  if choiceDisplay[4] then
    love.graphics.print("Y " .. choiceDisplay[4], cx, cy-cd) 
  else
    love.graphics.print("Y", cx, cy-cd) 
  end

  local p = (maxtime - timer)/maxtime
  love.graphics.setColor(200/p,200*p,200*p)
  love.graphics.rectangle("fill",0,0,math.min(maxtime - timer,1000)/maxtime* width,0.1*height)
end
