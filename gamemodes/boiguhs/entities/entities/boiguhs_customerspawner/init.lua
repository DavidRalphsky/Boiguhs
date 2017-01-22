ENT.Base		= "base_point"
ENT.Type 		= "point"

function ENT:Initialize()
	timer.Create("SpawnBoiguhCustomer", 30, 0, function() self:SpawnBoiguhCustomer() end)
	timer.Pause("SpawnBoiguhCustomer")
end

function ENT:SpawnBoiguhCustomer()
	timer.Adjust("SpawnBoiguhCustomer", ((60/GAMEMODE:GetMorale()*4)/GAMEMODE:GetDifficulty()), 0, function() self:SpawnBoiguhCustomer() end)
	local cust = ents.Create("boiguhs_customer")
	cust:SetPos(self:GetPos())
	cust:Spawn()

end