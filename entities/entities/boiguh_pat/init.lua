AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate025x025.mdl")

	self:SetMaterial("models/flesh")
	self:SetColor(Color(255, 255, 255))
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:Wake() end
	
	self.Sizzle = CreateSound(self,"General.BurningFlesh")
end

local killme = false
function ENT:Think()
	if(self:WaterLevel() == 3) then
		self:Extinguish()
	end
	
	if(self:IsOnFire() and !killme) then
		if(game.GetMap() == "gm_boiguhsfix") then
			killme = true
			FireBells()
			timer.Simple(1,function() FireBells() end)
		end
	end
end

function FireBells()
	local bells = ents.FindByName("fire_sensor_*")
	timer.Simple(2, function()
		for i=1, table.Count(bells) do
			bells[i]:Fire("ToggleSound")
		end
	end)
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

-- 130 to 170 is cooked

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