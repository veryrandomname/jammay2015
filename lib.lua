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


character = {
	hunger = 100,
	health = 100,
	mentalhealth = 100,
	bleeding = false,
	damage = 10,	
	inventory = {{name="dummy"},{name="A Red Blue Unicorn"}

			

		}
	}
	
function status()
	local function addspeak(string)
        	f = f  .. "\n" .. string2
	end

	local f = ""
	if hunger >= 95 then 
		addspeak("You are not hungry at all, this makes you feel more convenient.")
		mentalhealth = mentalhealth + 3
	elseif hunger >= 70 then
		addspeak("You feel slightly hungry.")
	elseif hunger >= 50 then
		addspeak("You are hungry you should eat something.")
	elseif hunger >= 25 then
		addspeak("You feel really hungry, you feel dizzy")
		mentalhealth = mentalhealth - 5
	elseif hunger >= 1 then
		addspeak("You are almost starving. You need to eat somthing!")
		mentalhealth = mentalhealth - 10
	else
		addspeak("Your stomach hurts.")
		health = health - 20
		mentalhealth = mentalhealth - 10
	end
	
	--apply hunger
	hunger = hunger - 3

	--apply bleeding
	if bleeding == true then
		addspeak("You lose blood.")
		health = health - 10
		mentalhealth = mentalhealth - 5
	end

	--health section
	if health >= 100 and not bleeding then
		addspeak("You are physical alright and feel strong.")
	elseif health >= 80 and not bleeding then
		addspeak("You have some small injuries, but you feel okay.")		
	elseif health >= 50 then 
		addspeak("You feel pain when you, while moving.")
	elseif health >= 30 then 
		addspeak("You problems when you try to move forward.")
	elseif health < 30 and health > 0 then
		addspeak("You feel pain, you concerns about your situation")
		mentalhealth = mentalhealth - 5  
	elseif health <= 0 then
		addspeak("The world turns black. You are dead.")		
	end

	--mentalhealth

	if mentalhealth >= 100 then
		addspeak("You are confident and feel conscious.")
	elseif mentalhealth >= 80 then
		addspeak("You have mixed feelings.")
	elseif mentalhealth >= 60 then
		addspeak("You have mixed feelings and you don't feel confident anylonger.")
	elseif mentalhealth >= 30 then
		addspeak("You feel inconvenient.")
	elseif mentalhealth >= 15 then
		addspeak("You feel dizzy. You start to see blurry.") 
	elseif mentalhealth < 15 and mentalhealth > 0 then
		addspeak("You are scared. You cannot see clear shape and have headache.")
	else
		addspeak("The world turns black and you lose consciousness.")
	end
	
	--return the whole status
	speak(f)
	

		
end

function speak(s, txt)
	--os.execute("espeak ".."'".. s.."'")
	os.execute("echo \"" .. s .."\" | " .. "festival --tts")  
	if txt == nil then
		screentxt = s
	else
		screentxt = txt
	end	

end 

function character.inventory:add(item)
	table.insert(self, item)
end
function character.inventory:show()
	speak("You open your bag and you see", "You open your bag and you see:")
	
	for i,v in pairs(self) do
		if v.name ~= nil then
			speak(v.name)
			
		end	
	end
end

character.inventory:add({name = "appel",
typ = food,
use = 
function()
	hunger = hunger + 4
end
}
)
