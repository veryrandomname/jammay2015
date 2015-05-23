function timedChoice(maxtime, fail, ... )
  local arg = {...}
  local time,c = coroutine.yield(#arg,maxtime)

  if time > maxtime then
    return fail(time)
  else
    local f = arg[c]
    return f(time)
  end
end

function choice(...)
  return timedChoice(math.huge, function()end, ...)
end

speak = print
