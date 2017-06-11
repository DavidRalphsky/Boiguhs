AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Name = "Bottom Bun"
	self.Desc = "Base for a Boiguh"

	self:SetModel("models/hunter/plates/plate025x025.mdl")

	self:SetMaterial("models/props_wasteland/quarryobjects01")
	self:SetColor(Color(255, 255, 0))

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:Wake() end
	
	self.Sizzle = CreateSound(self,"General.BurningFlesh")
	self.Count  = 1
	self.Active = true
end

function ENT:Think()
	if(self:WaterLevel() == 3) then
		self:Extinguish()
	end
end

-- GRILL STUFF
function ENT:StartTouch(ent)
	if(ent:GetClass() == "boiguhs_grill") then
		self:EmitSound("ambient/levels/canals/toxic_slime_sizzle"..math.random(3,4)..".wav")
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
	if self.Active == false then return end
	
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

	if(string.Explode("_",ent:GetClass())[1] == "boiguh" or ent:GetClass() == "boiguhs_ratcorpse") then
		if(ent:GetClass()=="boiguh_bot") then 
			if(table.Count(self:GetChildren()) < 1) then return end
			ent.Active = false 
		end
		if(ent:GetClass()=="boiguh_top") then 
			if(table.Count(self:GetChildren()) < 1) then return end
			self.Active = false 
		end
		
		local count = 3 * self.Count
		if(ent:GetClass()=="boiguh_bac" or ent:GetClass()=="boiguh_tom") then
			count = (3 * self.Count)-1.5
		end
		
		ent:SetPos(self:LocalToWorld(Vector(0,0,count)))
		self.Count = self.Count + 1		
		
		ent:SetAngles(self:LocalToWorldAngles(Angle(0,ent:GetAngles()[2],0)))		
		ent:SetParent(self)
	end
end

function ENT:OnRemove()
	self.Sizzle:Stop()
end