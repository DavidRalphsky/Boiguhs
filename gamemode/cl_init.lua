include("boiguhs/gamemode/core/sh_core.lua")
--[[local normal = {"boiguh_bot","boiguh_top","boiguh_che","boiguh_let","boiguh_tom","boiguh_pat","boiguh_bac","boiguhs_grill","boiguhs_register","boiguhs_fireextinguisher"}
hook.Add("PreDrawHalos", "boiguhs_tutorialhalos", function()
	--if GAMEMODE:GetDifficulty() == 1 then
		local ent = LocalPlayer():GetEyeTrace().Entity
		if table.HasValue(normal,ent:GetClass()) then
			halo.Add({ent}, Color(0,255,0,255), 3, 3, 1, true, true)
		end
	--end
end)

hook.Add("PostDrawOpaqueRenderables","boiguhs_tutorialtext", function()
	local ent = LocalPlayer():GetEyeTrace().Entity
	if table.HasValue(normal,ent:GetClass()) and LocalPlayer():GetPos():Distance(ent:GetPos()) < 100  then
		local pos = ent:GetPos() + ent:OBBCenter() + ent:GetUp()*5
		local yaw = LocalPlayer():EyeAngles().y-90
		cam.Start3D2D(pos,Angle(0,yaw,90), 0.5)
			draw.SimpleText(ent.Name or "Error","DermaDefault",0,-35,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)
			draw.SimpleText(ent.Desc or "Error","DermaDefault",0,-25,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end)]]--

local hat = ClientsideModel("models/props/cs_office/snowman_hat.mdl")
hat:SetNoDraw(true)
hook.Add("PostPlayerDraw", "boiguhs_accessories", function(ply)
	if not IsValid(ply) or not ply:Alive() then return end

	--[[local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) --Get the distance between you and the player

	if ( Distance < 1000 ) then --If the distance is less than 1000 units, it will draw the name

		local pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_L_Clavicle")) + ply:GetForward()*4.1 + ply:GetUp()*-2 + ply:GetRight()*1.1


		cam.Start3D2D(pos,ply:GetAngles()+Angle(0,50,90), 0.025)
			surface.SetDrawColor(255, 0, 0, 255)
			surface.SetMaterial(Material("boiguhs/namebadge"))
			surface.DrawRect(-110, -40, 220, 30)

			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(Material("boiguhs/namebadge"))
			surface.DrawRect(-110, -10, 220, 80)

			draw.SimpleText("HELLO, my name is","CloseCaption_Bold",0,-40,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
			draw.SimpleText(ply:GetName(),"CloseCaption_BoldItalic",0,13,Color(0,0,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		cam.End3D2D()
	end]]--

	local attach_id = ply:LookupAttachment("eyes")
	if not attach_id then return end

	local attach = ply:GetAttachment(attach_id)

	if not attach then return end

	local pos = attach.Pos
	local ang = attach.Ang

	hat:SetModelScale(0.82, 0)
	pos = pos + (ang:Forward() * -1.7 + ang:Up() * 2.5 + ang:Right() * 0.1)
	ang:RotateAroundAxis(ang:Right(), -16)
	ang:RotateAroundAxis(ang:Forward(), 5)
	ang:RotateAroundAxis(ang:Up(), -93)

	hat:SetPos(pos)
	hat:SetAngles(ang)
	hat:SetRenderOrigin(pos)
	hat:SetRenderAngles(ang)
	hat:SetupBones()
	hat:DrawModel()
	hat:SetRenderOrigin()
	hat:SetRenderAngles()
end)
