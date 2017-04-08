AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:Initialize()
	self.Name = "Top Bun"
	self.Desc = "Final piece of a Boiguh"
	
	self:SetModel("models/hunter/plates/plate025x025.mdl")

	if SERVER then
		local top = ents.Create("prop_physics")
		top:SetModel("models/hunter/plates/plate.mdl")
		top:SetPos(self:LocalToWorld(Vector(1.5,1.5,1)))
		top:SetAngles(self:GetAngles())
		top:SetMaterial("models/props_wasteland/quarryobjects01")
		top:SetColor(Color(255, 255, 0))		
		top:Spawn()
		top:SetParent(self)
		
		local top2 = ents.Create("prop_physics")
		top2:SetModel("models/hunter/plates/plate.mdl")
		top2:SetPos(self:LocalToWorld(Vector(1.5,-1.5,1)))
		top2:SetAngles(self:GetAngles())
		top2:SetMaterial("models/props_wasteland/quarryobjects01")
		top2:SetColor(Color(255, 255, 0))		
		top2:Spawn()
		top2:SetParent(self)
		
		local top3 = ents.Create("prop_physics")
		top3:SetModel("models/hunter/plates/plate.mdl")
		top3:SetPos(self:LocalToWorld(Vector(-1.5,1.5,1)))
		top3:SetAngles(self:GetAngles())
		top3:SetMaterial("models/props_wasteland/quarryobjects01")
		top3:SetColor(Color(255, 255, 0))		
		top3:Spawn()
		top3:SetParent(self)
		
		local top4 = ents.Create("prop_physics")
		top4:SetModel("models/hunter/plates/plate.mdl")
		top4:SetPos(self:LocalToWorld(Vector(-1.5,-1.5,1)))
		top4:SetAngles(self:GetAngles())
		top4:SetMaterial("models/props_wasteland/quarryobjects01")
		top4:SetColor(Color(255, 255, 0))		
		top4:Spawn()
		top4:SetParent(self)
	end
	
	self:SetMaterial("models/props_wasteland/quarryobjects01")
	self:SetColor(Color(255, 255, 0))

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:Wake() end
	
	self.Sizzle = CreateSound(self,"General.BurningFlesh")
end

function ENT:Think()
	if(self:WaterLevel() == 3) then
		self:Extinguish()
	end
end

-- GRILL STUFF
function ENT:StartTouch(ent)
	if(ent:GetClass() == "boiguhs_grill") then
		self.Sizzle:SetSoundLevel(60)
		self.Sizzle:Play()
	end
end

function ENT:EndTouch(ent)
	if(ent:GetClass() == "boiguhs_grill") then
		self.Sizzle:Stop()
	end
end


function ENT:Touch(ent)	
	if(ent:GetClass() == "boiguhs_grill") then
		if (self.NextTouch or 0) > CurTime() then return end
		self.NextTouch = CurTime()+0.1
	
		self:GetPhysicsObject():Wake()
		local r = self:GetColor().r
		local g = self:GetColor().g
		local b = self:GetColor().b
		self:SetColor(Color(math.Clamp(r-1,0,255),math.Clamp(g-1,0,255),math.Clamp(b-1,0,255)))
		if(self:GetColor().r == 0 and self:GetColor().g == 0 and self:GetColor().b == 0) then
			self:Ignite(60)
		end
	end
end

function ENT:OnRemove()
	self.Sizzle:Stop()
end