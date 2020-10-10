
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
	if not self.defaultFOV then self.defaultFOV = self:GetOwner():GetFOV() end

	if self.HasZoom and self.Zoomed then 
		return self.ZoomFOV / self.defaultFOV
	end
	
	return 1
end




function SWEP:DrawScope()
	if not (self.Zoomed ) then return false end
	
	local scrw = ScrW()
	local scrh = ScrH()
	local hscrw = scrw / 2
	local hscrh = scrh / 2
	local ratio = scrw / scrh
	
	local traceargs = util.GetPlayerTrace( LocalPlayer() )
	traceargs.filter = { self:GetOwner(), self:GetOwner():GetVehicle() or nil}
	local trace = util.TraceLine(traceargs)
		
	--local scrpos = trace.HitPos:ToScreen()
	--local devx = scrw2 - scrpos.x - 0.5
	--local devy = scrh2 - scrpos.y - 0.5

	surface.SetDrawColor(100, 0, 0, 255) 

	local rectsides = ((scrw - scrh) / 2) * 0.7

	surface.SetDrawColor(100, 0, 0, 255) 
	
	local baselen = rectsides + scrw * 0.18
	local basewide = scrh * 0.01
	local basewide2 = basewide * 2
	local centersep = scrh * 0.02

	--render.UpdateRefractTexture()
	surface.SetDrawColor( 0, 0, 0, 255 )

	--surface.SetMaterial( Material( "gmod/scope-refract" ) )
	--surface.DrawTexturedRect( rectsides, 0, ( scrw - rectsides * 2 ), scrh )

	surface.SetMaterial( Material( "weapons/scopes/rg_parascope" ) )
	surface.DrawTexturedRect( hscrw - ( scrw - rectsides * 2 ) / 4, scrh / 4, ( scrw - rectsides * 2 ) / 2, scrh / 2 )

	surface.SetMaterial( Material( "gmod/scope" ) )
	surface.DrawTexturedRect( rectsides, 0, scrw - rectsides * 2, scrh )
	--[[
	surface.SetFont( "BudgetLabel" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( hscrw * 0.90, hscrh * 1.08 ) 
	if trace.HitSky then
		surface.DrawText( "0000M" )
	else
		surface.DrawText( math.Round( ( trace.HitPos - trace.StartPos ):Length() / 52.49 ) .. "M" )
	end
	]]
	surface.DrawRect(                    0, 0, rectsides + 2, scrh )
	surface.DrawRect( scrw - rectsides - 2, 0, rectsides + 4, scrh )
	
	return true
end




function SWEP:DrawReticule(screenpos, aimRadius, fillFraction, colourFade)
	--if not CLIENT then return end
	
	ACF.SWEP.DrawReticule(self, screenpos, aimRadius, fillFraction, colourFade)
end




local function GetCurrentACFSWEP()

    if not ( LocalPlayer():Alive() or LocalPlayer():InVehicle() ) then return end
	
	local self = LocalPlayer():GetActiveWeapon()
	
	if not ( self and self.BulletData ) then return end

	if not ( self:GetOwner():Alive() or self:GetOwner():InVehicle() ) then return end
    
    return self

end





hook.Add("HUDPaint", "ACFWep_HUD", function()

	local self = LocalPlayer():GetActiveWeapon()
	if not ( self and self.BulletData ) then return end
	if ( not self:GetOwner():Alive() ) or self:GetOwner():InVehicle() then return end
	
	local drawcircle = true
	
	local scrpos

	if drawcircle then

		local traceargs = util.GetPlayerTrace(self:GetOwner())
		traceargs.filter = {self:GetOwner(), self:GetOwner():GetVehicle() or nil}
		local trace = util.TraceLine(traceargs)

		scrpos = trace.HitPos:ToScreen()
	end
	
	local isReloading = self:GetNetworkedBool( "reloading", false )
	local servstam = self:GetNetworkedFloat("ServerStam", 0)

	if self.Zoomed then self:DrawScope() else

	if not GetConVar("acfsweps_showHLCrosshair"):GetBool() then
		self:DrawReticule( scrpos, 0, 1, self:GetNetworkedFloat("ServerStam", 0) )
	end

end
	
	--self:DrawScope()
	
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



