AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false

function ENT:Initialize()
	self:SetModel("models/Humans/Group01/male_02.mdl")
	self:SetColor(Color(0,0,0,0))
	self:SetRenderMode(4)
	self:SetAngles(Angle(0,0,0))
	
	self:SetSolid(SOLID_NONE)
	
	if SERVER then
		self:SetBloodColor(-1)
		
		local glass = ents.Create("prop_physics")
		glass:SetModel("models/props/de_nuke/truck_nuke_glass.mdl")
		glass:SetPos(self:LocalToWorld(Vector(-180,0,0)))
		glass:SetAngles(self:LocalToWorldAngles(Angle(0,90,0)))
		glass:SetParent(self)
		glass:SetSolid(SOLID_NONE)
		
		local body = ents.Create("prop_physics")
		body:SetModel("models/props/de_nuke/truck_nuke.mdl")
		body:SetPos(self:LocalToWorld(Vector(-180,0,0)))
		body:SetAngles(self:LocalToWorldAngles(Angle(0,90,0)))
		body:SetParent(self)	
		body:SetSolid(SOLID_NONE)
	end	
	
	self:SetHealth(99999)
end

-- AI stuff
function ENT:RunBehaviour()	
	while (true) do
		timer.Simple(3, function() 
			local buncrate = nil
			if SERVER then
				buncrate = ents.Create("boiguhs_buncrate")
				buncrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				buncrate:SetAngles(self:GetAngles())
				buncrate:Spawn()				
			end
			
			buncrate:GetPhysicsObject():SetVelocity((self:GetRight()*320)+(self:GetUp()*150))
		end)
		
		timer.Simple(4, function() 
			local producecrate = nil
			if SERVER then
				producecrate = ents.Create("boiguhs_producecrate")
				producecrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				producecrate:SetAngles(self:GetAngles())
				producecrate:Spawn()					
			end
			
			producecrate:GetPhysicsObject():SetVelocity((self:GetRight()*320)+(self:GetUp()*150))
		end)
		
		timer.Simple(5, function() 
			local buncrate = nil
			local meatcrate = nil
			if SERVER then
				meatcrate = ents.Create("boiguhs_meatcrate")
				meatcrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				meatcrate:SetAngles(self:GetAngles())
				meatcrate:Spawn()				
			end
			
			meatcrate:GetPhysicsObject():SetVelocity((self:GetRight()*320)+(self:GetUp()*150))
		end)
		
		self.loco:SetDesiredSpeed(200)
		self:MoveToPos(self:LocalToWorld(Vector(1600,0,0)))
			
		self:Remove()
		
		coroutine.yield()
	end
end

list.Set( "NPC", "boiguhs_supplytruck", {
	Name = "Boiguhs Supply Truck",
	Class = "boiguhs_supplytruck",
	Category = "Boiguhs"
} )