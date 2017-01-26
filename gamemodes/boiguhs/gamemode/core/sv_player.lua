function GM:PlayerInitialSpawn(ply)
	ply:SetModel("models/player/group01/male_0"..math.random(1,9)..".mdl")
	
	ply:SetTeam(1)
	ply:SetGravity(1)
	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(150)
	ply:SetNoCollideWithTeammates(true)
	
	local hat = ents.Create("prop_physics")
	hat:SetModel("models/props/cs_office/snowman_hat.mdl")
	hat:SetPos(ply:LocalToWorld(Vector(1.4,0,70)))
	hat:SetModelScale(hat:GetModelScale() * 0.80)
	hat:SetAngles(Angle(0,-90,0))
	hat:SetSolid(SOLID_NONE)
	hat:SetParent(ply,1)
	
	timer.Simple(1,function()		
		ply:SetMaxHealth(2147483647)
		ply:SetHealth(2147483647)
	end)	
end

function GM:PlayerLoadout(ply)
	ply:Give("weapon_physcannon")
	return true
end

function BlockSuicide(ply)
	return false
end
hook.Add("CanPlayerSuicide", "boiguhs_suicide", BlockSuicide)