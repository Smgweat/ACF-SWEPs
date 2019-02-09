
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "ai_translations.lua" )
AddCSLuaFile( "sh_anim.lua" )
AddCSLuaFile( "shared.lua" )

include( "ai_translations.lua" )
include( "sh_anim.lua" )
include( "shared.lua" )

function SWEP:OnRemove()

	if not IsValid(self.FakeCrate) then return end
	
	local crate = self.FakeCrate
	timer.Simple(15, function() if IsValid(crate) then crate:Remove() end end)

end


local nosplode = {AP = true, HP = true, FLR = true}
local nopen = {HE = true, SM = true, FLR = true}
function SWEP:DoAmmoStatDisplay()
    
    local bdata = self.BulletData
	PrintTable( bdata ) 
	if bdata.IsShortForm then
		bdata = ACF_ExpandBulletData(table.Copy(bdata))
	end
    
    local roundType = bdata.Type
	
	if bdata.Tracer and bdata.Tracer > 0 then 
		roundType = roundType .. "-T"
	end

	local sendInfo = string.format( "%smm %s ammo: %im/s speed",
                                    tostring(bdata.Caliber * 10),
									roundType,
									self.ThrowVel or bdata.MuzzleVel)

	local RoundData = list.Get("ACFRoundTypes")[ bdata.Type ]
    
	if RoundData and RoundData.getDisplayData then
		local DisplayData = RoundData.getDisplayData( bdata )
        
        if not nopen[bdata.Type] then
            sendInfo = sendInfo .. string.format( 	", %.1fmm pen",
                                                    DisplayData.MaxPen)
        end
        
        if not nosplode[bdata.Type] then
			if DisplayData.BlastRadius then
				sendInfo = sendInfo .. string.format( 	", %.1fm blast",
														DisplayData.BlastRadius)
			end
        end
            
	end
	
	self.Owner:SendLua(string.format("GAMEMODE:AddNotify(%q, \"NOTIFY_HINT\", 10)", sendInfo))
end


function SWEP:Deploy()
	print (self.Owner)
	self.RecoilShock = Angle( 0, 0, 0 )
	--SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
	if not self.Owner:IsNPC() then
		--self:DoAmmoStatDisplay()
		
		if self.Zoomed then
			self:SetZoom(false)
		end
    end
	--PrintTable(getmetatable(self))
end


function SWEP:FireBullet()

	local MuzzlePos = self.Owner:GetShootPos()
	
	print( self.Owner, self.Owner:GetShootPos(), self.Owner:GetPos() )

	local MuzzleVec = self.Owner:GetAimVector()
	local angs = self.Owner:EyeAngles()	
	local MuzzlePos2 = MuzzlePos + angs:Forward() * self.AimOffset.x + angs:Right() * self.AimOffset.y
	local MuzzleVecFinal = MuzzleVec --self:inaccuracy(MuzzleVec, self.Inaccuracy)
	
	print( MuzzleVecFinal )
	
	self.BulletData["Pos"] = MuzzlePos
	--print ( self.BulletData["MuzzleVel"] )
	--print ( MuzzleVec )
	--print ( MuzzleVecFinal )
	self.BulletData["Flight"] = ( self.BulletData["MuzzleVel"] * MuzzleVecFinal * 52.4590163934 ) + self.Owner:GetVelocity()
	print ( self.BulletData["Flight"] )
	self.BulletData["Owner"] = self.Owner
	print ( self.BulletData["Owner"] )
	self.BulletData["Gun"] = self

	if self.BeforeFire then
		self:BeforeFire()
	end
	
	ACF_CreateBulletSWEP(self.BulletData, self, ACF.SWEP.LagComp or false)
	
	self:MuzzleEffect( MuzzlePos2, MuzzleVec, true )
	
end




function SWEP:MuzzleEffect( MuzzlePos, MuzzleDir, realcall )

end




function SWEP.CallbackEndFlight(index, bullet, trace)
	if not (ACF.SWEP.AlwaysDust or (bullet.Gun and bullet.Gun.AlwaysDust)) then return end
	if not trace.Hit then return end
	
	local pos = trace.HitPos
	local dir = (pos - trace.StartPos):GetNormalized()
	
	local Effect = EffectData()
		if bullet.Gun then
			Effect:SetEntity(bullet.Gun)
		end
		
		Effect:SetOrigin(pos - trace.Normal)
		Effect:SetNormal(dir)
		Effect:SetRadius((bullet.ProjMass * (bullet.Flight:Length() / 39.37)) / 10) -- ditched realism for more readability at range
		util.Effect( "acf_sniperimpact", Effect, true, true)
end