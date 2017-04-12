ENT.Type 		= "anim"
ENT.PrintName 	= "Restaurant Seat"
ENT.Author 		= "David Ralphsky"
ENT.Spawnable 	= true
ENT.AdminOnly 	= false

function ENT:SetRequest(val)
	self.Entity:SetNWBool("BoigRequest",val,true)
end

function ENT:GetRequest()
	return self.Entity:GetNWBool("BoigRequest")
end

function ENT:SetSprite(val)
	self.Entity:SetNWString("BoigSprite",val)
end

function ENT:GetSprite()
	return self.Entity:GetNWString("BoigSprite")
end