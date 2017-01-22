ENT.Base		= "base_point"
ENT.Type 		= "point"

function ENT:Initialize()
	timer.Create("SpawnBoiguhCar", 360/GAMEMODE:GetDifficulty(), 0, function() self:SpawnBoiguhCar() end)
	timer.Pause("SpawnBoiguhCar")
end

function ENT:SpawnBoiguhCar()
	if(GAMEMODE:GetMorale() > 5) then
		local car = ents.Create("boiguhs_car")
		car:SetPos(self:GetPos())
		car:Spawn()
	end
end

function ENT:OnRemove()
	if(timer.Exists("SpawnBoiguhCar")) then timer.Destroy("SpawnBoiguhCar") end
end