AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= false

function ENT:Initialize()
	self:SetNoDraw(true)
	
	self:SetSolid(SOLID_NONE)
	
	if SERVER then
		self:SetBloodColor(-1)
				
		local body = ents.Create("prop_physics")
		body:SetModel("models/props/de_nuke/truck_nuke.mdl")
		body:SetPos(self:LocalToWorld(Vector(-180,0,0)))
		body:SetAngles(self:LocalToWorldAngles(Angle(0,90,0)))
		body:SetParent(self)	
		body:SetSolid(SOLID_NONE)
	
		local glass = ents.Create("prop_physics")
		glass:SetModel("models/props/de_nuke/truck_nuke_glass.mdl")
		glass:SetPos(self:LocalToWorld(Vector(-180,0,0)))
		glass:SetAngles(self:LocalToWorldAngles(Angle(0,90,0)))
		glass:SetParent(self)
		glass:SetSolid(SOLID_NONE)
	end	
	
	self:SetHealth(99999)
end

-- AI stuff
function ENT:RunBehaviour()	
	while (true) do
		local right,up,speed,distance,wait = self.Right or 320, self.Up or 150, self.Speed or 200, self.Distance or 1600, self.Wait or 3
		timer.Simple(wait, function() 
			local buncrate = nil
			if SERVER then
				buncrate = ents.Create("boiguhs_buncrate")
				buncrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				buncrate:SetAngles(self:GetAngles())
				buncrate:Spawn()				
			end
			
			buncrate:GetPhysicsObject():SetVelocity((self:GetRight()*right)+(self:GetUp()*up))
		end)
		
		timer.Simple(wait+1, function() 
			local producecrate = nil
			if SERVER then
				producecrate = ents.Create("boiguhs_producecrate")
				producecrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				producecrate:SetAngles(self:GetAngles())
				producecrate:Spawn()					
			end
			producecrate:GetPhysicsObject():SetVelocity((self:GetRight()*right)+(self:GetUp()*up))
		end)
		
		timer.Simple(wait+2, function() 
			local buncrate = nil
			local meatcrate = nil
			if SERVER then
				meatcrate = ents.Create("boiguhs_meatcrate")
				meatcrate:SetPos(self:LocalToWorld(Vector(-330,30,60)))
				meatcrate:SetAngles(self:GetAngles())
				meatcrate:Spawn()				
			end
			
			meatcrate:GetPhysicsObject():SetVelocity((self:GetRight()*right)+(self:GetUp()*up))
		end)
		
		self.loco:SetDesiredSpeed(speed)
		self:MoveToPos(self:LocalToWorld(Vector(distance,0,0)))
			
		self:Remove()
		
		coroutine.yield()
	end
end

list.Set( "NPC", "boiguhs_supplytruck", {
	Name = "Boiguhs Supply Truck",
	Class = "boiguhs_supplytruck",
	Category = "Boiguhs"
} )