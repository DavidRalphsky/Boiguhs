function GM:PlayerInitialSpawn(ply)
	ply:SetModel("models/player/group01/male_0"..math.random(1,9)..".mdl")
	
	ply:SetTeam(1)
	ply:SetGravity(1)
	ply:SetWalkSpeed(150)
	ply:SetRunSpeed(150)
	ply:SetNoCollideWithTeammates(true)
	
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
