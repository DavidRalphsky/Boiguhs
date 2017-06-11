AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate025x025.mdl")

	self:SetMaterial("models/props_pipes/Pipesystem01a_skin3")
	self:SetColor(Color(0, 255, 0))

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
local sizzle
function ENT:StartTouch(ent)
	if(ent:GetClass() == "boiguhs_grill") then
		self:EmitSound("ambient/levels/canals/toxic_slime_sizzle"..math.random(3,4)..".wav")
		sizzle = CreateSound(self,"General.BurningFlesh")
		sizzle:SetSoundLevel(60)
		sizzle:Play()
	end
end

function ENT:EndTouch(ent)
	if(ent:GetClass() == "boiguhs_grill") then
		sizzle:Stop()
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