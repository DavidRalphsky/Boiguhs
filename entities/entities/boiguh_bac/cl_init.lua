include("shared.lua")

ENT.Name = "Bacon"
ENT.Desc = "90% grease, 10% heart attacks"
function ENT:Draw()
	self:DrawModel()
end