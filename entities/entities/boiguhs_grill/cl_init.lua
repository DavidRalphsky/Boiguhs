include("shared.lua")

ENT.Name = "Grill"
ENT.Desc = "Reduces risk of salmonella by 3%"
function ENT:Draw()
	self:DrawModel()
end