ENT.Type 		= "anim"
ENT.PrintName 	= "Boiguh Bottom"
ENT.Author 		= "David Ralphsky"
ENT.Spawnable 	= true
ENT.AdminOnly 	= false

function ENT:SetMoney(val)
	self.Entity:SetNWInt("BoigMoney",val)
end

function ENT:GetMoney()
	return self.Entity:GetNWInt("BoigMoney")
end