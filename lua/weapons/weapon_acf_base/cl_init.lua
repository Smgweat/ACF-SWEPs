
include( "ai_translations.lua" )
include( "sh_anim.lua" )
include( "shared.lua" )

function SWEP:ZoomThink()
	local zoomed = self:GetNetworkedBool("Zoomed")
	--Msg(zoomed)
	if zoomed ~= self.Zoomed then
		--print(zoomed, "has changed!!11")
		self.Zoomed = zoomed
		
		if zoomed then
			self.fromPos = self.curPos or Vector(0,0,0)
			self.toPos = ACF.SWEP.IronSights and (self.IronSightsPos or Vector(0,0,0)) or (self.ZoomPos or Vector(2, 2, 2))
			if ACF.SWEP.HalveSightPos then self.toPos = self.toPos / 2 end
			
			self.fromAng = self.curAng or Angle(0,0,0)
			self.toAng = self.IronSightsAng or Angle(0,0,0)
			self.zoomProgress = 0
		else
			self.fromPos = self.curPos or Vector(0,0,0)
			self.toPos = self.UnzoomedPos or Vector(0,0,0)
			
			self.fromAng = self.curAng or Angle(0,0,0)
			self.toAng = self.UnzoomedAng or Angle(0,0,0)
			self.zoomProgress = 0
		end
		
		
		if self.Zoomed then
			self.cachedmin = self.cachedmin or self.MinInaccuracy
			self.cacheddecayin = self.cacheddecayin or self.InaccuracyDecay
			self.cacheddecayac = self.cacheddecayac or self.AccuracyDecay
			
			self.MinInaccuracy = self.MinInaccuracy --* self.ZoomInaccuracyMod
			self.InaccuracyDecay = self.InaccuracyDecay --* self.ZoomDecayMod
			self.AccuracyDecay = self.AccuracyDecay --* self.ZoomDecayMod
		else			
			if self.cachedmin then
				self.MinInaccuracy = self.cachedmin
				self.InaccuracyDecay = self.cacheddecayin
				self.AccuracyDecay = self.cacheddecayac
				
				self.cachedmin = nil
				self.cacheddecayin = nil
				self.cacheddecayac = nil
			end
		end
		
	end
end




function SWEP:AdjustMouseSensitivity()
	if not self.defaultFOV then self.defaultFOV = self.Owner:GetFOV() end

	if self.HasZoom and self.Zoomed then 
		return self.ZoomFOV / self.defaultFOV
	end
	
	return 1
end




function SWEP:DrawScope()
	if not (self.Zoomed and self.HasScope) then return false end
	
	local scrw = ScrW()
	local scrw2 = ScrW() / 2
	local scrh = ScrH()
	local scrh2 = ScrH() / 2
	
	local traceargs = util.GetPlayerTrace(LocalPlayer())
	traceargs.filter = {self.Owner, self.Owner:GetVehicle() or nil}
	local trace = util.TraceLine(traceargs)
		
	local scrpos = trace.HitPos:ToScreen()
	local devx = scrw2 - scrpos.x - 0.5
	local devy = scrh2 - scrpos.y - 0.5

	surface.SetDrawColor(0, 0, 0, 255) 

	local rectsides = ((scrw - scrh) / 2) * 0.7

	surface.SetDrawColor(0, 0, 0, 255) 
	
	local baselen = rectsides + scrw * 0.18
	local basewide = scrh * 0.01
	local basewide2 = basewide * 2
	local centersep = scrh * 0.02
	surface.DrawRect(0 - devx, scrh2 - basewide - devy, baselen, basewide2)
	surface.DrawRect(scrw - baselen - devx, scrh2 - basewide - devy, baselen, basewide2)
	surface.DrawRect(scrw2 - basewide - devx, scrh - (baselen - rectsides*1.5) - devy, basewide2, (baselen - rectsides*1.5))
	
	surface.DrawLine(0 - devx, scrh2 - devy, scrw2 - centersep - devx, scrh2 - devy)
	surface.DrawLine(scrw2 + centersep - devx, scrh2 - devy, scrw - devx, scrh2 - devy)
	surface.DrawLine(scrw2 - devx, scrh - devy, scrw2 - devx, scrh2 + centersep - devy)
	

	surface.SetDrawColor(0, 0, 0, 255) 
	
	surface.SetMaterial(Material("gmod/scope"))
	surface.DrawTexturedRect(rectsides - devx, 0 - devy, scrw - rectsides * 2, scrh)
	
	surface.DrawRect(0, 0, rectsides + 2 - devx, scrh)
	surface.DrawRect(scrw - rectsides - 2 - devx, 0, rectsides + 2 + devx, scrh)
	
	if math.abs(devy) >= 0.5 then
		surface.DrawRect(rectsides + 2 - devx, 0, scrw - rectsides * 2, -devy)
		surface.DrawRect(rectsides + 2 - devx, scrh - devy, scrw - rectsides * 2, devy)
	end
	
	return true
end




function SWEP:DrawReticule(screenpos, aimRadius, fillFraction, colourFade)
	if not CLIENT then return end
	
	ACF.SWEP.DrawReticule(self, screenpos, aimRadius, fillFraction, colourFade)
end




local function GetCurrentACFSWEP()

    if not ( LocalPlayer():Alive() or LocalPlayer():InVehicle() ) then return end
	
	local self = LocalPlayer():GetActiveWeapon()
	
	if not ( self and self.BulletData ) then return end

	if not ( self.Owner:Alive() or self.Owner:InVehicle() ) then return end
    
    return self

end





hook.Add("HUDPaint", "ACFWep_HUD", function()

	local self = LocalPlayer():GetActiveWeapon()
	
	if not ( self and self.BulletData ) then return end

	if not (self.Owner:Alive() or self.Owner:InVehicle()) then return end
	
	local drawcircle = true
	
	local scrpos
	if drawcircle then
		local traceargs = util.GetPlayerTrace(LocalPlayer())
		traceargs.filter = {self.Owner, self.Owner:GetVehicle() or nil}
		local trace = util.TraceLine(traceargs)

		scrpos = trace.HitPos:ToScreen()
	end
	
	--[[
	local isReloading = self:GetNetworkedBool( "reloading", false )
	local servstam = self:GetNetworkedFloat("ServerStam", 0)
	
	local servinacc = self:GetNetworkedFloat("ServerInacc", self.MaxInaccuracy)
	if servinacc ~= self.curServInacc then
		self.timeDiff = CurTime() - self.lastServRecv or CurTime()
		self.lastServRecv = CurTime()
		self.lastServInacc = self.curServInacc
		self.curServInacc = servinacc
		self.curVisInacc = 1--self.lastServInacc
		self.smoothFactor = (self.curServInacc - self.lastServInacc) * self.timeDiff
	end

	--self.curVisInacc = math.Clamp(self.curVisInacc + self.smoothFactor, math.min(self.lastServInacc, self.curServInacc), math.max(self.lastServInacc, self.curServInacc))

	local aimRadius = drawcircle and ScrW() / 2 --* self.curVisInacc / self.Owner:GetFOV()
	local fractLeft = 1
	
	if self.PressedTime then
		local duration = CurTime() - self.PressedTime
		fractLeft = math.Clamp(duration, 0, self.ChargeTime) / self.ChargeTime
	end
	
	if isReloading then
		if not self.wasReloading then
			self.reloadBegin = CurTime()
			self.lastReloadTime = self.ReloadByRound and (self.ReloadTime * (self.Primary.ClipSize - self:Clip1()) + self.ReloadTime) or self.ReloadTime
		end
		
		if drawcircle then
			fractLeft = math.Clamp(self.lastReloadTime - (CurTime() - self.reloadBegin), 0, self.lastReloadTime) / self.lastReloadTime
		end
	end
	self.wasReloading = isReloading

	--]]
	
	if drawcircle then
		self:DrawReticule( scrpos, 0, 1, self:GetNetworkedFloat("ServerStam", 0) )
	end
	
	self:DrawScope()
	
	self.lastHUDDraw = CurTime()
	
end)




function SWEP:ZoomTween(t)
	if t then
		t = (t - 0.5) * 2
		
		return ( ( (t + 1)^2 ) / ( t^2 + 1 ) ) / 2
	else
		return 0
	end
end

local lissax = 3
local lissay = 4
local lissasep = math.pi / 2

hook.Add( "PreRender", "ACFWep_PreRender", function()

    local self = GetCurrentACFSWEP()
	if self then    
    
		local curTime = SysTime()
	
        local axis = self.RecoilAxis
        if axis then 
        
            local axisLength = axis:Length()
            if axisLength < 0.001 then
            
                self.RecoilAxis = Vector(0,0,0)
                
            else
			
				local recoilDamping = self.RecoilDamping * 18000
			
				local timeDiff = curTime - (self.lastPreRender or curTime)
				local decayTime = axisLength / recoilDamping
				timeDiff = math.min(timeDiff, decayTime)
			
				local accumulatedRecoil = axisLength * timeDiff - (recoilDamping * timeDiff * timeDiff) / 2
				local newAxisLength = -recoilDamping * timeDiff + axisLength
			
                local ply = LocalPlayer()
                local eye = ply:EyeAngles()
                local roll = eye.r
                
                local normAxis = axis:GetNormalized()

                eye:RotateAroundAxis(normAxis, accumulatedRecoil)
                eye.r = roll
                
                ply:SetEyeAngles(eye)
				
				self.RecoilAxis = normAxis * newAxisLength
            
            end

        end
        
        self.lastPreRender = curTime
        
    end
    
end )



