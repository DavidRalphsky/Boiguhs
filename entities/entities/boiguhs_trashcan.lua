ENT.Type      = "anim"
ENT.PrintName = "Boiguh Trash Can"
ENT.Author    = "Andreblue"
ENT.Spawnable = true
ENT.AdminOnly = false

AddCSLuaFile()
local EntBlackList = {
    player,
    boiguhs_grill,
    boiguhs_supplytruck,
    boiguhs_customer,
    boiguhs_car,
    boiguhs_register,
    boiguhs_producecrate,
    boiguhs_meatcrate,
    boiguhs_fireextinguisher,
    boiguhs_customerspawner,
    boiguhs_carspawner,
    boiguhs_buncrate,
    ai_truckspawn,
    ai_drivethrough,
    ai_customer_seatpoint,
    boiguhs_money,
    
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
    if(ent:GetClass() == "boiguhs_grill") then
        if (self.NextTouch or 0) > CurTime() then return end
        self.NextTouch = CurTime()+0.1
        self:GetPhysicsObject():Wake()
    end
    if ent:IsPlayer() then return end
    SafeRemoveEntity(ent)
end