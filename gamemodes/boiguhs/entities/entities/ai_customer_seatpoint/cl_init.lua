include('shared.lua')
function ENT:Draw()
	self:DrawModel()
	
	if(self:GetRequest()) then
		render.SetMaterial(Material(self:GetSprite()))
		render.DrawSprite(self.Entity:LocalToWorld(Vector(20,0,75)),32,32,Color(255,255,255,255))
	end
end