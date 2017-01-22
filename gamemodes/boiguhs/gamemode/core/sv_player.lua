function GM:PlayerInitialSpawn(ply)
	ply:SetModel("models/player/group01/male_0"..math.random(1,9)..".mdl")
	ply:Give("weapon_physcannon")
	
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
--[[local CMoveData = FindMetaTable("CMoveData")
function CMoveData:RemoveKeys(keys)
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end
hook.Add("SetupMove", "BG_DisableJump&Crouch", function(ply,mvd,cmd)
	if mvd:KeyDown(IN_JUMP) then
		mvd:RemoveKeys(IN_JUMP)`
	end
	if mvd:KeyDown(IN_DUCK) then
		mvd:RemoveKeys(IN_DUCK)
	end
end)--]]

function BlockSuicide(ply)
	return false
end
hook.Add("CanPlayerSuicide", "boiguhs_suicide", BlockSuicide)