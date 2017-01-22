AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate1x5.mdl")
	
	self:SetMaterial("phoenix_storms/gear")

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