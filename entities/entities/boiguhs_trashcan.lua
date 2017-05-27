ENT.Type      = "anim"
ENT.PrintName = "Boiguh Trash Can"
ENT.Author    = "Andreblue"
ENT.Spawnable = true
ENT.AdminOnly = false

AddCSLuaFile()
local EntWhiteList = {
    boiguh_bac = true,
    boiguh_bot = true,
    boiguh_let = true,
    boiguh_che = true,
    boiguh_pat = true,
    boiguh_tom = true,
    boiguh_top = true,
    boiguhs_ratcorpse = true,
    boiguhs_money = true,
    boiguhs_fireextinguisher = true,
    
}
function ENT:Initialize()
    self:SetModel("models/props_junk/TrashBin01a.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end
	
    local phys = self:GetPhysicsObject()
    if (IsValid(phys)) then phys:Wake() end
end
function ENT:Touch(ent)    
    if EntWhiteList[ent:GetClass()] then
        if (self.NextTouch or 0) > CurTime() then return end
        self.NextTouch = CurTime()+0.1
        self:GetPhysicsObject():Wake()
        SafeRemoveEntity(ent)
    end
end