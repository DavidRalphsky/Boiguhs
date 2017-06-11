include("shared.lua")

ENT.Name = "Lettuce"
ENT.Desc = "Rabbit food"
function ENT:Draw()
	self:DrawModel()
end