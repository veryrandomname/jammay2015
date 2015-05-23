require("lib")

function level()
  hunger = 0
  speak("hallo netter typ")

  function uberfall()
    hunger = hunger +1 
    speak("eyy du")
  end

  function clownkommt()
    speak("clown")
  end

  choice(uberfall, clownkommt, verhungert)

  timedChoice(1, function()error("time out")end, uberfall, clownkommt)

  error("end")
  end

return coroutine.create(level)
