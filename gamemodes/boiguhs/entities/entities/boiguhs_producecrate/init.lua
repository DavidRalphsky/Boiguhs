AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate001a.mdl")
	self:SetPos(self:LocalToWorld(Vector(-10,0,20)))
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	if (SERVER) then self:PhysicsInit(SOLID_VPHYSICS) end

	local phys = self:GetPhysicsObject()
	if (IsValid(phys)) then phys:Wake() end
end

function ENT:Use()
	self:EmitSound("physics/wood/wood_crate_break"..math.random(1,3)..".wav")
	
	local let1 = ents.Create("boiguh_let")
	let1:SetPos(self:LocalToWorld(Vector(-10,10,-15)))
	let1:SetAngles(self:GetAngles())
	let1:Spawn()
	
	local let2 = ents.Create("boiguh_let")
	let2:SetPos(self:LocalToWorld(Vector(-10,10,-10)))
	let2:SetAngles(self:GetAngles())
	let2:Spawn()
	
	local let3 = ents.Create("boiguh_let")
	let3:SetPos(self:LocalToWorld(Vector(-10,10,-5)))
	let3:SetAngles(self:GetAngles())
	let3:Spawn()
	
	local let4 = ents.Create("boiguh_let")
	let4:SetPos(self:LocalToWorld(Vector(-10,-10,-15)))
	let4:SetAngles(self:GetAngles())
	let4:Spawn()
	
	local let5 = ents.Create("boiguh_let")
	let5:SetPos(self:LocalToWorld(Vector(-10,-10,-10)))
	let5:SetAngles(self:GetAngles())
	let5:Spawn()
	
	local let6 = ents.Create("boiguh_let")
	let6:SetPos(self:LocalToWorld(Vector(-10,-10,-5)))
	let6:SetAngles(self:GetAngles())
	let6:Spawn()
	
	---------
	
	local che1 = ents.Create("boiguh_che")
	che1:SetPos(self:LocalToWorld(Vector(10,-10,-15)))
	che1:SetAngles(self:GetAngles())
	che1:Spawn()
	
	local che2 = ents.Create("boiguh_che")
	che2:SetPos(self:LocalToWorld(Vector(10,-10,-10)))
	che2:SetAngles(self:GetAngles())
	che2:Spawn()
	
	local che3 = ents.Create("boiguh_che")
	che3:SetPos(self:LocalToWorld(Vector(10,-10,-5)))
	che3:SetAngles(self:GetAngles())
	che3:Spawn()
	
	local che4 = ents.Create("boiguh_che")
	che4:SetPos(self:LocalToWorld(Vector(10,10,-15)))
	che4:SetAngles(self:GetAngles())
	che4:Spawn()
	
	local che5 = ents.Create("boiguh_che")
	che5:SetPos(self:LocalToWorld(Vector(10,10,-10)))
	che5:SetAngles(self:GetAngles())
	che5:Spawn()
	
	local che6 = ents.Create("boiguh_che")
	che6:SetPos(self:LocalToWorld(Vector(10,10,-5)))
	che6:SetAngles(self:GetAngles())
	che6:Spawn()
	
	---------
	
	local tom1 = ents.Create("boiguh_tom")
	tom1:SetPos(self:LocalToWorld(Vector(0,-13,-20)))
	tom1:SetAngles(self:GetAngles())
	tom1:Spawn()
	
	local tom2 = ents.Create("boiguh_tom")
	tom2:SetPos(self:LocalToWorld(Vector(0,-7,-20)))
	tom2:SetAngles(self:GetAngles())
	tom2:Spawn()
	
	local tom3 = ents.Create("boiguh_tom")
	tom3:SetPos(self:LocalToWorld(Vector(0,13,-20)))
	tom3:SetAngles(self:GetAngles())
	tom3:Spawn()
	
	local tom4 = ents.Create("boiguh_tom")
	tom4:SetPos(self:LocalToWorld(Vector(0,7,-20)))
	tom4:SetAngles(self:GetAngles())
	tom4:Spawn()
	
	local tom5 = ents.Create("boiguh_tom")
	tom5:SetPos(self:LocalToWorld(Vector(13,0,-20)))
	tom5:SetAngles(self:GetAngles())
	tom5:Spawn()
	
	local tom6 = ents.Create("boiguh_tom")
	tom6:SetPos(self:LocalToWorld(Vector(7,0,-20)))
	tom6:SetAngles(self:GetAngles())
	tom6:Spawn()
	
	local tom7 = ents.Create("boiguh_tom")
	tom7:SetPos(self:LocalToWorld(Vector(-13,0,-11)))
	tom7:SetAngles(self:GetAngles())
	tom7:Spawn()
	
	local tom8 = ents.Create("boiguh_tom")
	tom8:SetPos(self:LocalToWorld(Vector(-7,0,-20)))
	tom8:SetAngles(self:GetAngles())
	tom8:Spawn()
	
	self:Remove()
end