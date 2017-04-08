AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false

function ENT:Initialize()	
	if SERVER then 		
		self:SetModel(self.Model or "models/Humans/Group01/male_0"..math.random(1,9)..".mdl") 
	end

	self:SetHealth(99999)
	
	self.Searching = true
	self.Leaving   = false
	self.Seated    = false
	self.IsSick    = false
	self.Seat      = nil
	self.Request   = ""	
	self.Pos       = self:GetPos()
	self.Num	   = 0

	self.Entity:SetCollisionBounds(Vector(-4,-4,0), Vector(4,4,64))
	
	util.PrecacheSound("vo/npc/male01/pain01.wav")
	util.PrecacheSound("vo/npc/male01/pain02.wav")
	util.PrecacheSound("vo/npc/male01/pain03.wav")
	util.PrecacheSound("vo/npc/male01/pain04.wav")
	util.PrecacheSound("vo/npc/male01/pain05.wav")
	util.PrecacheSound("vo/npc/male01/pain06.wav")
	util.PrecacheSound("vo/npc/male01/pain07.wav")
	util.PrecacheSound("vo/npc/male01/pain08.wav")
	util.PrecacheSound("vo/npc/male01/pain09.wav")
end

function ENT:OnContact(_ent)
	if !self.Seated then return end
	
	local ent = _ent
	
	if(ent:GetParent():IsValid()) then ent = _ent:GetParent() end
	if(#ent:GetChildren()<1)      then return end
	
	if(ent:GetClass()=="boiguh_bot" and !ent.Active) then
		for i=1, #ent:GetChildren() do
			if(ent:IsOnFire() or ent:GetChildren()[i]:IsOnFire()) then 
				self:EmitSound("ambient/fire/ignite.wav") self.Run = true 
				self:Ignite(60) 
			end
		end
		
		self:EmitSound("vo/SandwichEat09.mp3",65,math.random(80,150))
		self:CalcPay(ent:GetChildren())
		ent:Remove()
	end
end

function IsCooked(ent)
	if GAMEMODE:Debug() then print(ent:GetClass()) PrintTable(ent:GetColor()) end
	
	if(IsValid(ent) and ent:GetColor().r > (45+(GAMEMODE:GetDifficulty()*10)) and ent:GetColor().r < (150-(GAMEMODE:GetDifficulty()*10))) then return 1 else return 0 end
end

function ENT:ProcessOrder(req,tbl,order)
	table.remove(tbl,1)
	local num = 0
	
	for i=1, #tbl do
		if((tbl[i]:GetClass()=="boiguh_pat" or tbl[i]:GetClass()=="boiguh_bac") and tbl[i]:GetColor().r == 255) then 
			timer.Simple(2, function() self.IsSick = true end) 
		end
	
		if(IsValid(tbl[i]) and tbl[i]:GetClass() == order[i]) then
			if(tbl[i]:GetClass()=="boiguh_pat" or tbl[i]:GetClass()=="boiguh_bac") then 
				num = num + IsCooked(tbl[i])
			else
				num = num + 1
			end
		end
	end
	
	if GAMEMODE:Debug() then
		print("======")
		print("ORDER DEBUG!")
		print("------")
		print("req - (Food request)")
		print(req)
		print("------")
		print("tbl - (Table of bun's children as entities)")
		PrintTable(tbl)
		print("------")	
		print("order - (Table of order as classnames)")
		PrintTable(order)
		print("------")
		print("Max possible: "..#order)
		print("Payed: "..num)
		print("======")
	end
	
	return num
end

function ENT:CalcPay(tbl)
	self.Seated = false
	
	local req   = self.Request
	local order = {"Invalid order"}
	
	if(req == "cheese") then
		order = {"boiguh_che","boiguh_pat"}
	
	elseif(req == "bigmac") then
		order = {"boiguh_let","boiguh_pat","boiguh_bot","boiguh_che","boiguh_pat"}
		
	elseif(req == "cheeseandlettuce") then
		order = {"boiguh_let","boiguh_che","boiguh_pat"}
		
	elseif(req == "doublecheese") then
		order = {"boiguh_pat","boiguh_che","boiguh_pat"}
		
	elseif(req == "lettuce") then
		order = {"boiguh_let","boiguh_pat"}
		
	elseif(req == "bacon") then
		order = {"boiguh_bac","boiguh_pat"}

	elseif(req == "baconcheese") then
		order = {"boiguh_tom","boiguh_bac","boiguh_che","boiguh_pat"}
		
	elseif(req == "complicatedcheese") then
		order = {"boiguh_tom","boiguh_let","boiguh_che","boiguh_pat"}
		
	elseif(req == "deluxebacon") then
		order = {"boiguh_let","boiguh_bac","boiguh_pat","boiguh_bac"}
		
	elseif(req == "vegan") then
		order = {"boiguh_tom","boiguh_let","boiguh_let"}
	
	end
	
	local num = self:ProcessOrder(self.Request,tbl,order)
	
	local positive = {"vo/npc/male01/answer32.wav","vo/npc/male01/nice.wav"}
	local negative = {"vo/npc/male01/question26.wav"}	
	
	timer.Simple(1, function()
		if num == 0 then
			self:EmitSound(table.Random(negative),80)
		elseif(num == #order) then
			self:EmitSound(table.Random(positive),80)
		end
		if(self.IsSick == false and !self.Run) then self.Leaving = true end
	end)

	
	GAMEMODE:AddMorale(num)
	if GAMEMODE:Debug() then print("Morale set to "..GAMEMODE:GetMorale()) end
	
	for i=1, num do
		if SERVER then
			local money = ents.Create("prop_physics")
			if(!IsValid(money)) then return end
			money:SetModel("models/hunter/plates/plate025x05.mdl")
			money:SetMaterial("phoenix_storms/fender_white")
			money:SetColor(Color(0,255,0))
			money:SetPos(self:LocalToWorld(Vector(0,0,50)))
			money:SetAngles(Angle(math.random(0,180),math.random(0,180),math.random(0,180)))
			money:Spawn()
			money:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			money:GetPhysicsObject():SetVelocity((self:GetForward()*150)+(self:GetUp()*150))
		end
	end
end

function ENT:RequestRand()
	local burgers = {"cheese","bigmac","cheeseandlettuce","doublecheese","lettuce","bacon","baconcheese","complicatedcheese","deluxebacon","vegan"}
	local request = table.Random(burgers)
	
	self.Seat:Request("boiguhs/"..request)
	self.Request = request
	
	if GAMEMODE:Debug() then print("I want a "..self.Request) end
end

-- AI stuff
function ENT:RunBehaviour()	
	while (true) do
		if(self.Searching) then
			self:FindASeat()
		elseif(self.Leaving) then
			local pos = self:GetPos()
			if(self.Seat:IsValid() and self.Seat != nil) then self.Seat.Taken = false self.Seat:ClearReq() end
			self.Seated = false
			timer.Simple(2, function() 
				if(self.IsSick) then 
					self:EmitSound("vo/npc/male01/no02.wav",120)
					timer.Simple(1,function() self:TakeDamage(99999,nil,nil) end)
				end 
			end)
			self:StartActivity(ACT_WALK)
			self.loco:SetDesiredSpeed(100)
			self:MoveToPos(self.Pos)
			self:Remove()	
		elseif(self.Run) then
			self.Seat:ClearReq()
			self.Seated = false
			self:StartActivity(ACT_RUN)
			self.loco:SetDesiredSpeed(250)
			self:MoveToPos(self.Pos)
			self:Remove()	
		end
		
		coroutine.yield()
	end
end

function ENT:FindASeat()
	local seats = ents.FindByClass("ai_customer_seatpoint")
	self.Num    = self.Num + 1
	local num   = math.random(1,#seats)
	
	if !IsValid(seats[num]) or self.Num > #seats then self:Remove() return end
	if seats[num].Taken then self:FindASeat() return end
	
	seats[num].Taken = true
	self.Searching   = false
	self.loco:FaceTowards(seats[num]:GetPos())
	self:StartActivity(ACT_WALK)
	self.loco:SetDesiredSpeed(100)
	self:MoveToPos(seats[num]:GetPos())
	self:StartActivity(ACT_IDLE)
	self:SetSequence(self:LookupSequence("Silo_Sit"))
	self:SetPos(seats[num]:LocalToWorld(Vector(22,4,0)))
	self:SetAngles(seats[num]:GetAngles())
	self.Seated = true
	self.Seat   = seats[num]
	self:RequestRand()
	timer.Simple(120, function() 
		if(IsValid(self) and self.Seated) then
			GAMEMODE:SubtractMorale(5)
			self:EmitSound("vo/npc/male01/question26.wav",80)
			self.Leaving = true 
		end
	end)
end

function ENT:OnInjured(dmg)
	if (self.Next or 0) > CurTime() then return end 
	self.Next = CurTime()+0.5 
	
	self:EmitSound("vo/npc/male01/pain0"..math.random(1,9)..".wav")
end

function ENT:OnKilled(dmginfo)
	local body = ents.Create("prop_ragdoll")
	body:SetPos(self:GetPos())
	body:SetAngles(self:GetAngles())
	body:SetModel(self:GetModel())
	body:Spawn()
	body:Activate()
	body:SetSolid(SOLID_BSP)
	body:SetVelocity(Vector(0,0,1)*5000000)

	self:Remove()

	timer.Simple(15, function()	body:Remove() end)
end

function ENT:OnRemove()
	if(IsValid(self.Seat)) then self.Seat:ClearReq() self.Seat.Taken = false end
end

list.Set( "NPC", "boiguhs_customer", {
	Name = "Boiguhs Customer",
	Class = "boiguhs_customer",
	Category = "Boiguhs"
} )