AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/chair02a.mdl")
	self:SetPos(self:LocalToWorld(Vector(0,0,10)))
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:EnableMotion(false) end
	
	self.Taken   = false
end

function ENT:Request(mat)
	if SERVER then
	self.Entity:SetRequest(true)
	self.Entity:SetSprite(mat)
	end
end

function ENT:ClearReq()
	self.Entity:SetRequest(false)
end
