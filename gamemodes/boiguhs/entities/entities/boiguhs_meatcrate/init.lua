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
	
	local pat1 = ents.Create("boiguh_pat")
	pat1:SetPos(self:LocalToWorld(Vector(-10,10,-15)))
	pat1:SetAngles(self:GetAngles())
	pat1:Spawn()
	
	local pat2 = ents.Create("boiguh_pat")
	pat2:SetPos(self:LocalToWorld(Vector(-10,10,-10)))
	pat2:SetAngles(self:GetAngles())
	pat2:Spawn()
	
	local pat3 = ents.Create("boiguh_pat")
	pat3:SetPos(self:LocalToWorld(Vector(-10,10,-5)))
	pat3:SetAngles(self:GetAngles())
	pat3:Spawn()
	
	local pat4 = ents.Create("boiguh_pat")
	pat4:SetPos(self:LocalToWorld(Vector(-10,-10,-15)))
	pat4:SetAngles(self:GetAngles())
	pat4:Spawn()
	
	local pat5 = ents.Create("boiguh_pat")
	pat5:SetPos(self:LocalToWorld(Vector(-10,-10,-10)))
	pat5:SetAngles(self:GetAngles())
	pat5:Spawn()
	
	local pat6 = ents.Create("boiguh_pat")
	pat6:SetPos(self:LocalToWorld(Vector(-10,-10,-5)))
	pat6:SetAngles(self:GetAngles())
	pat6:Spawn()
	
	---------
	
	local bac1 = ents.Create("boiguh_bac")
	bac1:SetPos(self:LocalToWorld(Vector(10,-10,-15)))
	bac1:SetAngles(self:GetAngles())
	bac1:Spawn()
	
	local bac2 = ents.Create("boiguh_bac")
	bac2:SetPos(self:LocalToWorld(Vector(10,-10,-10)))
	bac2:SetAngles(self:GetAngles())
	bac2:Spawn()
	
	local bac3 = ents.Create("boiguh_bac")
	bac3:SetPos(self:LocalToWorld(Vector(10,10,-15)))
	bac3:SetAngles(self:GetAngles())
	bac3:Spawn()
	
	local bac4 = ents.Create("boiguh_bac")
	bac4:SetPos(self:LocalToWorld(Vector(10,10,-10)))
	bac4:SetAngles(self:GetAngles())
	bac4:Spawn()
	
	local bac5 = ents.Create("boiguh_bac")
	bac5:SetPos(self:LocalToWorld(Vector(5,10,-15)))
	bac5:SetAngles(self:GetAngles())
	bac5:Spawn()
	
	local bac6 = ents.Create("boiguh_bac")
	bac6:SetPos(self:LocalToWorld(Vector(5,10,-10)))
	bac6:SetAngles(self:GetAngles())
	bac6:Spawn()
	 
	local bac7 = ents.Create("boiguh_bac")
	bac7:SetPos(self:LocalToWorld(Vector(5,-10,-15)))
	bac7:SetAngles(self:GetAngles())
	bac7:Spawn()
	
	local bac8 = ents.Create("boiguh_bac")
	bac8:SetPos(self:LocalToWorld(Vector(5,-10,-10)))
	bac8:SetAngles(self:GetAngles())
	bac8:Spawn()
	
	self:Remove()
end