ENT.Base = "base_point"
ENT.Type = "point"

function ENT:Initialize()	
	self.Exit = self:LocalToWorld(Vector(400,0,0))	
end