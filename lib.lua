function timedChoice(maxtime, fail, ... )
  local arg = {...}
  local time,c = coroutine.yield(#arg,maxtime)

  if time > maxtime then
    return fail(time)
  else
    local f = arg[c]
    return f(time), f
  end
end

function choice(...)
  return timedChoice(math.huge, function()end, ...)
end

--character specificfunctions


character = {
	hunger = 100,
	health = 100,
	mentalhealth = 100,
	bleeding = false,
	damage = 10,	
	block = 7,
	dex = 10,
	inventory = {{name="dummy"},{name="A Red Blue Unicorn"}

			

		}
	}
	
function status()
	local f = ""

	local function addspeak(string)
        	f = f  .. "\n" .. string
	end

	if character.hunger >= 95 then 
		addspeak("You are not hungry at all, this makes you feel more convenient.")
		character.mentalhealth = character.mentalhealth + 3
	elseif character.hunger >= 70 then
		addspeak("You feel slightly hungry.")
	elseif character.hunger >= 50 then
		addspeak("You are hungry you should eat something.")
	elseif character.hunger >= 25 then
		addspeak("You feel really hungry, you feel dizzy")
		character.mentalhealth = character.mentalhealth - 5
	elseif hunger >= 1 then
		addspeak("You are almost starving. You need to eat somthing!")
		character.mentalhealth = character.mentalhealth - 10
	else
		addspeak("Your stomach hurts.")
		character.health = character.health - 20
		character.mentalhealth = character.mentalhealth - 10
	end
	
	--apply hunger
	character.hunger = character.hunger - 3

	--apply bleeding
	if character.bleeding == true then
		addspeak("You lose blood.")
		character.health = character.health - 10
		character.mentalhealth = character.mentalhealth - 5
	end

	--health section
	if character.health >= 100 and not character.bleeding then
		addspeak("You are physical alright and feel strong.")
	elseif character.health >= 80 and not character.bleeding then
		addspeak("You have some small injuries, but you feel okay.")		
	elseif character.health >= 50 then 
		addspeak("You feel pain when you, while moving.")
	elseif character.health >= 30 then 
		addspeak("You problems when you try to move forward.")
	elseif character.health < 30 and character.health > 0 then
		addspeak("You feel pain, you concerns about your situation")
		character.mentalhealth = character.mentalhealth - 5  
	elseif character.health <= 0 then
		addspeak("The world turns black. You are dead.")		
		os.exit()	
	end

	--mentalhealth

	if character.mentalhealth >= 100 then
		addspeak("You are confident and feel conscious.")
	elseif character.mentalhealth >= 80 then
		addspeak("You have mixed feelings.")
	elseif character.mentalhealth >= 60 then
		addspeak("You have mixed feelings and you don't feel confident anylonger.")
	elseif character.mentalhealth >= 30 then
		addspeak("You feel inconvenient.")
	elseif character.mentalhealth >= 15 then
		addspeak("You feel dizzy. You start to see blurry.") 
	elseif character.mentalhealth < 15 and character.mentalhealth > 0 then
		addspeak("You are scared. You cannot see clear shape and have headache.")
	else
		addspeak("The world turns black and you lose consciousness.")
		os.exit()	
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

function fight(enemy)
	local m ={}
	for k,v in pairs(enemy.moves) do	
		table.insert(m,v) 
	end
	while(character.health > 0 and enemy.health > 0)do
		m[math.random(1,#m)]()
	end
	status()
end


bear= {health = 20}
bear.moves = {
	leftpunch = 
	function() 
		speak("The bear is preparing an attack with its left paw.")
		choiceDisplay = {"Block left", "Block right", "Attack right",
				 "Attack left", "Dodge to the left", 
				 "Dodge to the right"}
		local result, c= timedChoice(
			10, 
			function()
				speak("The bear hits her right arm.")
				
			end,
			character.dodgeLeft,
			character.dodgeRight,
			character.attackLeft,
			character.attackRight,
			character.blockLeft,
			character.blockRight
			)
		
		if c == character.dodgeRight and result == true then
			speak("She was succesful.")
		
		elseif (character.dodgeLeft or character.attackLeft or	character.attackRight or 
			character.blockLeft or character.blockRight) then
			speak("The bear hits her.")
			character.health = character.health - 10
		end
	end,
	rightpunch = function()
		speak("The bear is preparing an attack with its right paw.")
		choiceDisplay = {"Block left", "Block right", "Attack right",
				 "Attack left", "Dodge to the left", 
				 "Dodge to the right"}
		local result, c = timedChoice(
			10, 
			function()
				speak("The bear hits her right arm.")
				
			end,
			character.dodgeLeft,
			character.dodgeRight,
			character.attackLeft,
			character.attackRight,
			character.blockLeft,
			character.blockRight
			)
		
		if c == character.dodgeRight and result == true then
			speak("She was succesful.")
		
		elseif (character.dodgeLeft or character.attackLeft or	character.attackRight or 
			character.blockLeft or character.blockRight) then
			speak("The bear hits her.")
			character.health = character.health - 10
		end
	end,
	dodge = function()
		speak("The bear tries to dodge your attack.")
		if(math.random(1,20) > 4) then
			speak("But she hits him.")
			bear.health = bear.health - character.damage
			
		end
	end
	}
	
character.dodgeLeft = function()
	speak("She tries to dodge to the left.")
	if(math.random(1, 20) > character.dex) then return false 
	else return true end
end
character.dodgeRight = function()
	speak("She tries to dodge to the right.")
	if(math.random(1, 20) > character.dex) then return false 
	else return true end
end

character.attackLeft = function()
	speak("She tries to Attack her enemy.")
	if(math.random(1, 20) > character.dex) then return false 
	else return true end
end

character.attackRight = function()
	speak("She tries to Attack her enemy.")
	if(math.random(1, 20) > character.dex) then return false 
	else return true end
end


character.blockLeft = function()
	speak("She tries to block the attack on your left side.")
	if(math.random(1, 20) > character.block) then return false 
	else return true end
end
character.blockRight = 
function()
	speak("She tries to block the attack on your right side.")
	if(math.random(1, 20) > character.block) then return false 
	else return true end
end

