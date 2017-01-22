include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	
	cam.Start3D2D(self:GetPos(),self:LocalToWorldAngles(Angle(0,180,90)), 1)
		surface.SetFont("Trebuchet24")
		surface.SetTextColor(255, 255, 255, 255)
		surface.SetTextPos(-20,-40)
		surface.DrawText("$"..self:GetMoney())
	cam.End3D2D()
end

