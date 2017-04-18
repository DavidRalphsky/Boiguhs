local difficulty = 1
function GM:SetDifficulty(diff)
	difficulty = diff
end

function GM:GetDifficulty()
	return difficulty
end

concommand.Add("boiguhs_setdifficulty", function(ply,cmd,args)
	if(!ply:IsAdmin() or args[1] == nil) then return end
	if(tonumber(args[1]) > 4 or tonumber(args[1]) < 0) then 
		print("Invalid difficulty!")
		return
	end
	
	GAMEMODE:SetDifficulty(tonumber(args[1]))
	ply:ConCommand("boiguhs_getdifficulty")
end)

concommand.Add("boiguhs_getdifficulty", function(ply,cmd,args)
	if(!ply:IsAdmin()) then return end
	local difficulties = {"Easy","Normal","Hard"}
	
	print("Boiguhs difficulty set to: "..difficulties[difficulty])
end)

local morale = 4
function GM:SetMorale(num)
	morale = num
end

function GM:AddMorale(num)
	morale = math.Clamp(morale + num, 4, 20)
end

function GM:SubtractMorale(num)
	morale = math.Clamp(morale - num, 4, 20)
end

function GM:GetMorale()
	return morale
end

concommand.Add("boiguhs_setmorale", function(ply,cmd,args)
	if(!ply:IsAdmin() or args[1] == nil) then return end
	
	GAMEMODE:SetMorale(args[1])
end)

local money = 0
function GM:SetMoney(num)
	money = num
end

function GM:AddMoney(num)
	money = money + num
end

function GM:SubtractMoney(num)
	money = money - num
end

function GM:GetMoney()
	return money
end

concommand.Add("boiguhs_setmoney", function(ply,cmd,args)
	if(!ply:IsAdmin() or tonumber(args[1]) == nil) then return end
	
	GAMEMODE:SetMoney(args[1])
end)

local qdebug = 0
function GM:SetDebug(num)
	qdebug = num
end

function GM:Debug()
	return qdebug
end

concommand.Add("boiguhs_debug", function(ply,cmd,args)
	if(!ply:IsAdmin() or args[1] == nil) then return end
	if(tonumber(args[1]) > 1 or tonumber(args[1]) < 0) then
		print("Invalid input!")
		return
	end
	
	GAMEMODE:SetDebug(tonumber(args[1]))
end)

function GM:CallTruck()
	local cost = 40+(GAMEMODE:GetDifficulty()*10)
	if(GAMEMODE:GetMoney() > cost) then
		GAMEMODE:SubtractMoney(cost)
		timer.Simple(5, function()
			ents.FindByClass("ai_truckspawn")[1]:SpawnTruck()
		end)
	end
end

local started = false
function GM:GameStarted()
	return started
end

function GM:StartGame()
	if started then return false end
	started = true
	
	timer.Simple(0.1, function() game.CleanUpMap() 

	PrintMessage(HUD_PRINTCENTER, "Boiguhs has started! You have 30 seconds to prepare!")
	
		
	timer.UnPause("SpawnBoiguhCustomer")
	timer.UnPause("SpawnBoiguhCar")

	local num1 = (math.random(60,120)/GAMEMODE:GetDifficulty())
	local num2 = 600
	
	if(GAMEMODE:GetDifficulty() == 3) then num2 = 300 end
	timer.Create("boiguhs_rat",     num1,0,function() SpawnARat()     end)
	timer.Create("boiguhs_ratswarm",num2,0,function() SpawnRatSwarm() end)
	end)
end

function SpawnARat()
	local rat = ents.Create("boiguhs_rat")
	rat:SetPos(Vector(0,0,-60))
	rat:Spawn()
		
	timer.Simple(25,function() 
		if IsValid(rat) then rat:Remove() end 
	end)
end

function SpawnRatSwarm( num )
	num = num or 10
	local rattab = {}
	for i = 1, num do
		rattab[ i ] = ents.Create("boiguhs_rat")
		rattab[ i ]:SetPos( Vector( 0, 0,-60 ) )
		rattab[ i ]:Spawn()
	end		
	timer.Simple(25,function() 
		for _, rat in ipairs( rattab ) do
			if IsValid( rat ) then
				rat:Remove()
				rattab[ _ ] = nil
			end
		end
	end)
end
BurgerTable = {
    cheese = {"boiguh_che","boiguh_pat"},
    bigmac = {"boiguh_let","boiguh_pat","boiguh_bot","boiguh_che","boiguh_pat"},
    cheeseandlettuce = {"boiguh_let","boiguh_che","boiguh_pat"},
    doublecheese = {"boiguh_pat","boiguh_che","boiguh_pat"},
    lettuce = {"boiguh_let","boiguh_pat"},
    bacon = {"boiguh_bac","boiguh_pat"},
    baconcheese = {"boiguh_tom","boiguh_bac","boiguh_che","boiguh_pat"},
    complicatedcheese = {"boiguh_tom","boiguh_let","boiguh_che","boiguh_pat"},
    deluxebacon = {"boiguh_let","boiguh_bac","boiguh_pat","boiguh_bac"},
    vegan = {"boiguh_tom","boiguh_let","boiguh_let"},
}
function GM:GetBurgers()
    return table.Copy(BurgerTable)
end

function GM:GetBurger(name)
    return table.Copy(BurgerTable[name]) or false
end


function GM:PostCleanupMap()
    local trashCan = ents.Create( "boiguhs_trashcan" )
    trashCan:SetPos(Vector(761, 606, -29))
    trashCan:SetAngles(Angle( 0, -81, 0))
	trashCan:Spawn()
    local Phys = trashCan:GetPhysicsObject()
    if IsValid(Phys) then
        Phys:EnableMotion( false )
    end
end