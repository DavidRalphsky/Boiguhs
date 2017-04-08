AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false

function ENT:Initialize()
	self:SetColor(Color(0,0,0,0))
	self:SetRenderMode(4)
	
	if SERVER then
		local burgers = {"cheese","bigmac","cheeseandlettuce","doublecheese","lettuce","bacon","baconcheese","complicatedcheese","deluxebacon","vegan"}
		local models = {"models/props_vehicles/car004a_physics.mdl","models/props_vehicles/car003a_physics.mdl","models/props_vehicles/car005a_physics.mdl"}
		
		self.Request = table.Random(burgers)	
		self:SetModel("models/Humans/Group01/male_02.mdl")
		
		local car = ents.Create("prop_physics")
		car:SetModel(table.Random(models))
		car:SetPos(self:LocalToWorld(Vector(0,0,25)))
		car:SetAngles(self:GetAngles())
		car:SetParent(self)
	
		self.Driver = ents.Create("prop_physics")
		self.Driver:SetModel("models/Humans/Group01/male_0"..math.random(1,9)..".mdl")
		self.Driver:SetPos(self:LocalToWorld(Vector(0,15,5)))
		self.Driver:SetAngles(self:GetAngles())
		self.Driver:SetSequence(self.Driver:LookupSequence("silo_sit"))
		self.Driver:SetParent(self)
	end
	
	self:SetHealth(99999)
	
	self.Searching = true
	self.Leaving   = false
	self.Stop	   = nil
	
	self.Min 	   = 75
	self.Max	   = 110
	
	self.Entity:SetCollisionBounds(Vector(-30,-30,0), Vector(30,30,60))
end

function ENT:Draw()
	render.SetMaterial(Material("boiguhs/"..self.Request))
	render.DrawSprite(self.Entity:LocalToWorld(Vector(0,0,80)),32,32,Color(255,255,255,255))
end

function ENT:OnContact(_ent)
	if(self.Searching == true or self.Leaving == true) then return end
	
	local ent = _ent
	if(ent:GetParent():IsValid()) then ent = _ent:GetParent() end
	if(table.Count(ent:GetChildren())<1) then return end
	
	if(ent:GetClass()=="boiguh_bot" and ent.Active == false) then
		for i=1, table.Count(ent:GetChildren()) do
			if(ent:IsOnFire() or ent:GetChildren()[i]:IsOnFire()) then self.Explode = true self.Driver:Ignite(60) end
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
		if(tbl[i]:GetClass()=="boiguh_pat" or tbl[i]:GetClass()=="boiguh_bac" and tbl[i]:GetColor().r == 255) then timer.Simple(2, function() self.IsSick = true end) end
	
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
	local req   = self.Request
	local order = {"Invalid order"}
	
	if(req == "cheese") then
		order = {"boiguh_che","boiguh_pat"}
	
	elseif(req == "bigmac") then
		order = {"boiguh_let","boiguh_pat","boiguh_bot","boiguh_che","boiguh_pat"}
		
	elseif(req == "cheeseandlettuce") then
		order = {"boiguh_tom","boiguh_let","boiguh_let"}
		
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
	
	timer.Simple(1.5, function()
		if num == 0 then
			self:EmitSound(table.Random(negative),80)
		elseif(num == #order) then
			self:EmitSound(table.Random(positive),80)
		end		
		
		timer.Simple(0.5, function()
			if(self.Explode and SERVER) then
				local boom = ents.Create("env_explosion")
				boom:SetPos(self:GetPos())
				boom:Spawn()
				boom:Fire("Explode")
				self:Remove()
			end
		end)
		
		self.Leaving = true
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
			money:GetPhysicsObject():SetVelocity((self:GetRight()*-150)+(self:GetUp()*150))
		end
	end
end


-- AI stuff
function ENT:RunBehaviour()	
	while (true) do
		if(self.Searching) then
			self:FindStop()
			
		elseif(self.Leaving) then
			self:SetRenderMode(4)
			self.loco:SetDesiredSpeed(200)
			self:MoveToPos(self.Stop.Exit)
			self:Remove()	
			
		elseif(self.Run) then
			self:StartActivity(ACT_RUN)
			self.loco:SetDesiredSpeed(800)
			self.loco:SetAcceleration(900)
			self:MoveToPos(self.Stop.Exit)
			self:Remove()
		end
		
		coroutine.yield()
	end
end

function ENT:FindStop()
	self.Stop = ents.FindByClass("ai_drivethrough")[1]

	if(IsValid(self.Stop)) then
		self.Searching = false
		self.loco:SetDesiredSpeed(200)
		self:MoveToPos(self.Stop:GetPos())
		self.loco:FaceTowards(self.Stop:GetPos())
		self:SetPos(self.Stop:GetPos())
		self:SetAngles(self.Stop:GetAngles())
		self:SetRenderMode(0)
		timer.Simple(120, function() if(IsValid(self) and !self.Leaving) then GAMEMODE:SubtractMorale(5) self.Leaving = true end end)
	end
end

list.Set( "NPC", "boiguhs_car", {
	Name = "Boiguhs Car",
	Class = "boiguhs_car",
	Category = "Boiguhs"
} )