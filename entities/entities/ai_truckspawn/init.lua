ENT.Base		= "base_point"
ENT.Type 		= "point"
ENT.PrintName 	= "Supply Truck Spawnpoint"
ENT.Author 		= "David Ralphsky"
ENT.Spawnable 	= false
ENT.AdminOnly 	= false

function ENT:KeyValue(k,v)
	if(k == "distance") then 
		self.Distance = v 
	elseif(k == "speed") then
		self.Speed    = tonumber(v)
	elseif(k == "wait") then
		self.Wait     = tonumber(v)
	elseif(k == "right") then
		self.Right    = tonumber(v)
	elseif(k == "up") then
		self.Up       = tonumber(v)
	elseif(k == "yaw") then
		self.Yaw	  = tonumber(v)
	end
end

function ENT:SpawnTruck()
	local truck = ents.Create("boiguhs_supplytruck")
	truck:SetPos(self:GetPos())
	truck:SetAngles(Angle(0,self.Yaw or 0,0))
	truck:Spawn()
	
	truck.Distance = self.Distance
	truck.Speed    = self.Speed
	truck.Wait     = self.Wait
	truck.Right    = self.Right
	truck.Up       = self.Up
end