AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate001a.mdl")
	self:SetPos(self:LocalToWorld(Vector(-10,0,20)))
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:Wake() end
end

function ENT:Use()
	self:EmitSound("physics/wood/wood_crate_break"..math.random(1,3)..".wav")
	
	local bot1 = ents.Create("boiguh_bot")
	bot1:SetPos(self:LocalToWorld(Vector(-10,10,-15)))
	bot1:SetAngles(self:GetAngles())
	bot1:Spawn()
	
	local bot2 = ents.Create("boiguh_bot")
	bot2:SetPos(self:LocalToWorld(Vector(-10,10,-10)))
	bot2:SetAngles(self:GetAngles())
	bot2:Spawn()
	
	local bot3 = ents.Create("boiguh_bot")
	bot3:SetPos(self:LocalToWorld(Vector(-10,10,-5)))
	bot3:SetAngles(self:GetAngles())
	bot3:Spawn()
	
	local bot4 = ents.Create("boiguh_bot")
	bot4:SetPos(self:LocalToWorld(Vector(-10,-10,-15)))
	bot4:SetAngles(self:GetAngles())
	bot4:Spawn()
	
	local bot5 = ents.Create("boiguh_bot")
	bot5:SetPos(self:LocalToWorld(Vector(-10,-10,-10)))
	bot5:SetAngles(self:GetAngles())
	bot5:Spawn()
	
	local bot6 = ents.Create("boiguh_bot")
	bot6:SetPos(self:LocalToWorld(Vector(-10,-10,-5)))
	bot6:SetAngles(self:GetAngles())
	bot6:Spawn()
	
	local bot7 = ents.Create("boiguh_bot")
	bot7:SetPos(self:LocalToWorld(Vector(-10,10,0)))
	bot7:SetAngles(self:GetAngles())
	bot7:Spawn()
	
	local bot8 = ents.Create("boiguh_bot")
	bot8:SetPos(self:LocalToWorld(Vector(-10,-10,0)))
	bot8:SetAngles(self:GetAngles())
	bot8:Spawn()
	
	local bot9 = ents.Create("boiguh_bot")
	bot9:SetPos(self:LocalToWorld(Vector(-10,10,5)))
	bot9:SetAngles(self:GetAngles())
	bot9:Spawn()
	
	local bot10 = ents.Create("boiguh_bot")
	bot10:SetPos(self:LocalToWorld(Vector(-10,-10,5)))
	bot10:SetAngles(self:GetAngles())
	bot10:Spawn()
	
	---------
	
	local top1 = ents.Create("boiguh_top")
	top1:SetPos(self:LocalToWorld(Vector(10,-10,-15)))
	top1:SetAngles(self:GetAngles())
	top1:Spawn()
	
	local top2 = ents.Create("boiguh_top")
	top2:SetPos(self:LocalToWorld(Vector(10,-10,-10)))
	top2:SetAngles(self:GetAngles())
	top2:Spawn()
	
	local top3 = ents.Create("boiguh_top")
	top3:SetPos(self:LocalToWorld(Vector(10,-10,-5)))
	top3:SetAngles(self:GetAngles())
	top3:Spawn()
	
	local top4 = ents.Create("boiguh_top")
	top4:SetPos(self:LocalToWorld(Vector(10,10,-15)))
	top4:SetAngles(self:GetAngles())
	top4:Spawn()
	
	local top5 = ents.Create("boiguh_top")
	top5:SetPos(self:LocalToWorld(Vector(10,10,-10)))
	top5:SetAngles(self:GetAngles())
	top5:Spawn()
	
	local top6 = ents.Create("boiguh_top")
	top6:SetPos(self:LocalToWorld(Vector(10,10,-5)))
	top6:SetAngles(self:GetAngles())
	top6:Spawn()
	
	self:Remove()
end