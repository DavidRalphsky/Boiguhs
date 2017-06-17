AddCSLuaFile()

ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

function ENT:Initialize()
	self:SetModel("models/rat.mdl")
	self:SetModelScale(1.5)
	
	if SERVER then		
		local crown = ents.Create("prop_physics")
		crown:SetModel("models/player/items/demo/crown.mdl")
		crown:SetPos(self:LocalToWorld(Vector(9,1,10)))
		crown:SetAngles(Angle(8,-90,5))
		crown:Spawn()
		crown:SetParent(self)
		crown:SetSolid(SOLID_NONE)
		crown:SetModelScale(0.6)
	end	
	
	self:SetHealth(99999)
	self:DrawShadow(false)
	
	self.Hostile = true
	
	self.Entity:SetCollisionBounds(Vector(-10,-10,-10), Vector(10,10,10))
	
	self.Bite = CreateSound(self,"NPC_HeadCrab.Bite")
end

-- AI stuff
function ENT:SetEnemy(ent)
	self.Enemy = ent
end

function ENT:GetEnemy()
	return self.Enemy
end

function ENT:RunBehaviour()	
	while (true) do
		if(self.Hostile) then
			self:SetEnemy(table.Random(ents.FindByClass("player")))
			if IsValid(self:GetEnemy()) then
				--self.loco:FaceTowards(self:GetEnemy():GetPos())
				self:StartActivity(ACT_WALK)
				self.loco:SetDesiredSpeed(250)
				self:ChaseEnemy()
				self:StartActivity(ACT_IDLE)
			end
		end		
		coroutine.yield()
	end
end

function ENT:ChaseEnemy(options)
	local options = options or {}

	local path = Path("Follow")
	path:SetMinLookAheadDistance(options.lookahead or 300)
	path:SetGoalTolerance(options.tolerance or 20)
	path:Compute(self, self:GetEnemy():GetPos())

	if (!path:IsValid()) then return "failed" end

	while (path:IsValid() and IsValid(self:GetEnemy())) do

		if (path:GetAge() > 0.1) then
			path:Compute(self, self:GetEnemy():GetPos())
		end
		path:Update(self)

		if (options.draw) then path:Draw() end
		if (self.loco:IsStuck()) then
			self:HandleStuck()
			return "stuck"
		end
		
		if(self:GetEnemy():IsPlayer() and IsValid(self:GetEnemy()) and self:GetPos():Distance(self:GetEnemy():GetPos()) < 30) then
			if (self.NextBite or 0) > CurTime() then return end 
			self.NextBite = CurTime()+1.5
			self:GetEnemy():ViewPunch(Angle(-10, 0, 0))		
			self:GetEnemy():TakeDamage(1,self,self) 
			self.Bite:Play()
		else
			self.Bite:Stop()
		end
		coroutine.yield()
	end
	return "ok"
end

function ENT:OnInjured(dmg)
	self:EmitSound("vo/ravenholm/monk_pain09.wav")
	if dmg:GetDamageType() == 268435464 then return false end
	self:Remove()
end

list.Set("NPC", "boiguhs_rat", {
	Name = "Boiguhs Rat",
	Class = "boiguhs_ratking",
	Category = "Boiguhs"
})