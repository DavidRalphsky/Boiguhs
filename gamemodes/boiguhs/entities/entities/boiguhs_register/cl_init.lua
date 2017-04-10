include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	
	cam.Start3D2D(self:LocalToWorld(Vector(0,-5.5,0)),self:LocalToWorldAngles(Angle(0,180,90)), 0.25)
		draw.SimpleText("$","DermaDefault",-31,-48,Color(0,255,0,255),TEXT_ALIGN_CENTER)
		draw.SimpleText(tostring(self:GetMoney()),"Trebuchet18",17,-49,Color(0,255,0,255),TEXT_ALIGN_RIGHT)
	cam.End3D2D()
end

