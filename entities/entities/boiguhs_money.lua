ENT.Type      = "anim"
ENT.PrintName = "Boiguh Money"
ENT.Author    = "Andreblue"
ENT.Spawnable = true
ENT.AdminOnly = false

AddCSLuaFile()
function ENT:Initialize()
    self:SetModel("models/props/cs_assault/money.mdl")
    self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end