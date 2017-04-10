include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	
	render.SetMaterial(Material("boiguhs/buncrate"))
	render.DrawSprite(self.Entity:GetPos()+Vector(0,0,50),32,32,Color(255,255,255,255))
end