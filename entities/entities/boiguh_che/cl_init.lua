include("shared.lua")

ENT.Name = "Cheese"
ENT.Desc = "Definitely from the moon"
function ENT:Draw()
	self:DrawModel()
end