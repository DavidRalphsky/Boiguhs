AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/cashregister01a.mdl")

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:EnableMotion(false) end
end

function ENT:Think()
	if(gmod.GetGamemode().Name != "Sandbox") then
		self.Entity:SetMoney(GAMEMODE:GetMoney())
	end
end

function ENT:Touch(ent)
	if (self.Next or 0) > CurTime() then return end 
	self.Next = CurTime()+0.5 
	if(ent:GetModel() == "models/hunter/plates/plate025x05.mdl") then
		ent:Remove()
		GAMEMODE:AddMoney(5)
	end
end