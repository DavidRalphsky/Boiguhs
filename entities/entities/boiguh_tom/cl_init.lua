include("shared.lua")

ENT.Name = "Tomato"
ENT.Desc = "Straight from the GMO farm"
function ENT:Draw()
	self:DrawModel()
end