ENT.Base		= "base_point"
ENT.Type 		= "point"

function ENT:Initialize()
	timer.Create("SpawnBoiguhCustomer", 5, 0, function() self:SpawnBoiguhCustomer() end)
	//timer.Pause("SpawnBoiguhCustomer")
	
	self.Models = {"models/Humans/Group03/male_06.mdl","models/Humans/Group03m/Male_05.mdl","models/Humans/Group03/Female_02.mdl","models/Humans/Group02/Male_01.mdl"}
end

function ENT:SpawnBoiguhCustomer()
	//timer.Adjust("SpawnBoiguhCustomer", ((60/GAMEMODE:GetMorale()*4)/GAMEMODE:GetDifficulty()), 0, function() self:SpawnBoiguhCustomer() end)
	local cust = ents.Create("boiguhs_customer")
	cust:SetPos(self:GetPos())
	cust.Model = table.Random(self.Models)
	cust:Spawn()
end