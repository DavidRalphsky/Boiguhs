AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:KeyValue(k,v)
	if(k == "model") then 
		self.Model = v
	elseif(k == "material") then 
		self.Material = v 
	end
end


function ENT:Initialize()
	if self.Model then
		self:SetModel(self.Model)
	else
		self:SetModel("models/hunter/plates/plate1x5.mdl")
	end
	
	if self.Material then
		self:SetMaterial(self.Material)
	else
		self:SetMaterial("phoenix_storms/gear")
	end
		
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
		
	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:EnableMotion(false) end
end

function ENT:Touch(ply)
	if(ply:IsPlayer() and ply:IsValid()) then
		ply:Ignite(10)
	end
end