ENT.Base		= "base_point"
ENT.Type 		= "point"

function ENT:Initialize()
	timer.Create("SpawnBoiguhCustomer", 30, 0, function() self:SpawnBoiguhCustomer() end)
	timer.Pause("SpawnBoiguhCustomer")
	
	self.Models = {}
end

function ENT:KeyValue(k,v)
	if(string.sub(k,1,5) == "model") then 
		//self.Models[#self.Models+1] = v 
	end
end

function ENT:SpawnBoiguhCustomer()
	timer.Adjust("SpawnBoiguhCustomer", ((60/GAMEMODE:GetMorale()*4)/GAMEMODE:GetDifficulty()), 0, function() self:SpawnBoiguhCustomer() end)
	local cust = ents.Create("boiguhs_customer")
	cust:SetPos(self:GetPos())
	if !IsValid(self.Models) then
		cust.Model = "models/Humans/Group01/male_0"..math.random(1,9)..".mdl"
	else
		cust.Model = table.Random(self.Models)
	end
	cust:Spawn()
end