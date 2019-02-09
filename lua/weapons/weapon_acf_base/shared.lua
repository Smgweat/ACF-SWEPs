
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot				= 0						-- Slot in the weapon selection menu
    SWEP.SlotPos			= 0						-- Position in the slot
    SWEP.DrawAmmo			= true					-- Should draw the default HL2 ammo counter
    SWEP.AccurateCrosshair 	= true
    SWEP.DrawCrosshair		= true					-- Should draw the default crosshair
    SWEP.DrawWeaponInfoBox	= false					-- Should draw the weapon info box
    SWEP.BounceWeaponIcon	= false					-- Should the weapon icon bounce?
    SWEP.SwayScale			= 1.0					-- The scale of the viewmodel sway
    SWEP.BobScale			= 1.0					-- The scale of the viewmodel bob
    SWEP.UseHands 			= true

    SWEP.RenderGroup		= RENDERGROUP_OPAQUE

    -- Override this in your SWEP to set the icon in the weapon selection
    SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/swep" )

    -- This is the corner of the speech bubble
    SWEP.SpeechBubbleLid	= surface.GetTextureID( "gui/speech_lid" )

end

if SERVER then -- Server only variables

    SWEP.Weight			= 5		-- Decides whether we should switch from/to this
    SWEP.AutoSwitchTo	= false	-- Auto switch to if we pick it up
    SWEP.AutoSwitchFrom	= false	-- Auto switch from if you pick up a better weapon

end

if true then -- Shared variables

    SWEP.PrintName		= "ACF_SWEPS Base" -- 'Nice' Weapon name (Shown on HUD)
    SWEP.Author			= ""
    SWEP.Contact		= ""
    SWEP.Purpose		= ""
    SWEP.Instructions	= ""

    SWEP.Base 	  = "weapon_base"
    SWEP.Category = "ACF"

    SWEP.ViewModelFOV	= 54
    SWEP.ViewModelFlip	= false
    SWEP.HoldType 		= ""
    SWEP.ViewModel 		= ""
    SWEP.WorldModel 	= ""

    SWEP.Spawnable	= false
    SWEP.AdminOnly	= false
    --[[
	SWEP.Primary.Sound = ""

	sound.Add( 
	{
		name = SWEP.Primary.Sound,
		channel = CHAN_WEAPON,
		volume = 1.0,
		level = 80,
		pitch = { 90, 110 },
		sound = ""
	} )
	--]]
    --[[
	SWEP.Secondary.Sound = ""
  
	sound.Add( 
	{
		name = SWEP.Primary.Sound,
		channel = CHAN_WEAPON,
		volume = 1.0,
		level = 80,
		pitch = { 90, 110 },
		sound = ""
	} )
]]--

    sound.Add(
        {
            name = "acf_sweps_misfire",
            channel = CHAN_AUTO,
            volume = { 0.9, 1.1 },
            level = 80,
            pitch = { 90, 110 },
            sound = "weapons/pistol/pistol_empty.wav"
        } )

    SWEP.Primary.Ammo 		 = "none"
    SWEP.Primary.TPSound   	 = ""
    SWEP.Primary.DistSound 	 = ""
    SWEP.Primary.Delay		 = 0
    SWEP.Primary.ClipSize 	 = -1
    SWEP.Primary.DefaultClip = -1
    SWEP.Primary.Automatic 	 = false

    SWEP.Secondary.Ammo 	   = "none"
    SWEP.Secondary.TPSound     = ""
    SWEP.Secondary.DistSound   = ""
    SWEP.Secondary.Delay	   = 0
    SWEP.Secondary.ClipSize    = -1
    SWEP.Secondary.DefaultClip = -1
    SWEP.Secondary.Automatic   = false

    SWEP.ReloadTime = 1

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass	   = 1 	-- Weight in grams
    SWEP.Handling.Barrel   = 1 	-- Barrel length in milimeters
    SWEP.Handling.Balance  = 1 	-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom  = false
    SWEP.HasScope = false
    SWEP.IronSights = false
    SWEP.IronSightsPos = Vector(0, 0, 0)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0, 0, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType 	= "Rifle" 	-- For bullet length approximation
    SWEP.Caliber 	= 1 		-- Diameter in milimeters
    SWEP.Length 	= 1 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel 	= 1 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 1 		-- Weight in Grams ( Not grains! )

    SWEP.Class 		= "MG"
    SWEP.FlashClass = "MG"

end

function SWEP:InitBulletData()

    -- A band-aid to make my life easier
    local Ammunition = self.Ammunition
    local GunType 	 = self.GunType
    local Caliber 	 = self.Caliber / 10 -- Conversion from mm to cm
    local Length 	   = self.Length / 10 -- Conversion from mm to cm
    local MuzzleVel  = self.MuzzleVel
    local BulletMass = self.BulletMass

    if GunType == "Rifle" then
        Length = Length * 0.46 -- Because rounds are often measured in case length, Approximate rifle round
    elseif GunType == "Pistol" then
        Length = Length * 0.52 -- Because rounds are often measured in case length, Approximate handgun round
    end

    local FrontArea

    self.BulletData = {}

    if Ammunition == "AP" then
        self.BulletData["ShovePower"] 	= 0.2
        self.BulletData["Ricochet"]		= 75
        FrontArea 						= 3.1416 * ( Caliber / 2 )^2
    elseif Ammunition == "HP" then
        self.BulletData["ShovePower"] 	= 0.365
        self.BulletData["Ricochet"]		= 90
        FrontArea 						= 3.1416 * ( (Caliber + 0.33*Length) / 2 )^2
    end

    self.BulletData["Id"]					= "7.62mmMG" 									-- This value has no meaning
    self.BulletData["Caliber"]				= Caliber 										-- Predetermined
    self.BulletData["Colour"]				= Color(255, 255, 255)							-- This value has no meaning
    self.BulletData["DragCoef"]				= ( FrontArea / 10000 ) / ( BulletMass/1000 )	-- Auto determined, affects effective range
    self.BulletData["FrAera"]				= FrontArea 									-- Predetermined
    self.BulletData["LimitVel"]				= MuzzleVel + 100								-- Maximum velocity allowed
    self.BulletData["MuzzleVel"]			= MuzzleVel 									-- Predetermined
    self.BulletData["KETransfert"]			= 10.1 											-- Percentage of energy transferred on impact, 0 - 1
    self.BulletData["PenAera"]				= FrontArea^0.85 								-- Auto determined frontal area
    self.BulletData["ProjLength"]			= Length										-- Predetermined
    self.BulletData["ProjMass"]				= BulletMass/1000 								-- Predetermined, converted from g to kg
    self.BulletData["RoundVolume"]			= Length * FrontArea * 9.1						-- Auto determined
    self.BulletData["Type"]		    		= Ammunition									-- Predetermined
    self.BulletData["InvalidateTraceback"]	= true											-- Unknown
    self.BulletData["Tracer"]				= 2.5
    self.BulletData["ShovePower"]			= 1												-- 0.8 may be better

end

SWEP.LastAim = Vector()
SWEP.LastThink = CurTime()
SWEP.WasCrouched = false

function SWEP:Initialize()

    print( "Init_Swep" )
    print( "Swep_Type", self.HoldType )

    self:SetHoldType( self.HoldType )

    if self.HoldType == "ar2" then
        print( "Spawned weapon type AR2" )
        self:SetWeaponHoldType( 'ar2' )
    end

    if self.HoldType == "smg" then
        print( "Spawned weapon type SMG" )
        self:SetWeaponHoldType( 'smg' )
    end

    if self.HoldType == "pistol" then
        print( "Spawned weapon type Pistol" )
        self:SetWeaponHoldType( 'pistol' )
    end

    if SERVER then
        self:SetNPCMinBurst( 10 )
        self:SetNPCMaxBurst( self.ClipSize )
        self:SetNPCFireRate( self.Primary.Delay )
    end

    self:InitBulletData()
    self:UpdateFakeCrate()

    self.RecoilShock = Angle( 0, 0, 0 )

    if SERVER and self.BulletData.IsShortForm and not self.IsGrenadeWeapon then
        self.BulletData = ACF_ExpandBulletData(self.BulletData)
    end

    if SERVER then
        self.BulletData.OnEndFlight = self.CallbackEndFlight
    end

end


function SWEP:Think()

    if self.ThinkBefore then self:ThinkBefore() end

    local isReloading = self.Weapon:GetNetworkedBool( "reloading", false )

    if CLIENT then
        self:ZoomThink()

        self.DrawCrosshair	= GetConVar("acfsweps_showHLCrosshair"):GetBool()
        self.ViewModelFOV	= GetConVar("acfsweps_viewmodelFOV"):GetInt()

    end


    ACF.SWEP.Think(self)


    if self.ThinkAfter then self:ThinkAfter() end


    if SERVER then
        --self:SetNetworkedFloat("ServerInacc", self.Inaccuracy)
        self:SetNetworkedFloat("ServerStam", self.Owner.XCFStamina)

        if self.Owner:KeyDown(IN_ATTACK2) and self.HasZoom and self:CanZoom() and not self.Zoomed then
            self:SetZoom(true)
        elseif not self.Owner:KeyDown(IN_ATTACK2) and self.Zoomed then
            self:SetZoom(false)
        end

        --[[
        if self.Zoomed and not self:CanZoom() then
            self:SetZoom(false)
        end
        --]]

    end

    -- Determine if this is a client on a local server, or playing online.
    if ( (game.SinglePlayer() and SERVER) or ( not game.SinglePlayer() and CLIENT and IsFirstTimePredicted() ) ) then

        if self.RecoilShock == nil then self.RecoilShock = Angle( 0, 0, 0 ) end

        -- Smooth recoil function.
        if not self.Owner:IsNPC() and math.abs(self.RecoilShock.p) + math.abs(self.RecoilShock.y) > 0.1 then
            self.Owner:SetEyeAngles( self.Owner:EyeAngles() + self.RecoilShock * 0.2 )
            self.RecoilShock = self.RecoilShock * 0.8
        else
            self.RecoilShock = Angle( 0, 0, 0 )
        end

    end

end

function SWEP:CanZoom()

    local sprinting = self.Owner:KeyDown(IN_SPEED)
    if sprinting then return true end

    return true

end

function SWEP:SetZoom(zoom)

    if zoom == nil then
        self.Zoomed = not self.Zoomed
    else
        self.Zoomed = zoom
    end


    if SERVER then self:SetNetworkedBool("Zoomed", self.Zoomed) end

    if self.Zoomed then

        if SERVER then
            self:SetOwnerZoomSpeed(true)
            self.Owner:SetFOV(self.ZoomFOV, 0.25)
        end

    else

        self.MinInaccuracy = self.cachedmin
        self.InaccuracyDecay = self.cacheddecayin
        self.AccuracyDecay = self.cacheddecayac

        if SERVER then
            self:SetOwnerZoomSpeed(false)
            self.Owner:SetFOV(0, 0.25)
        end

    end

end




function SWEP:SetOwnerZoomSpeed(setSpeed)

    if setSpeed then

        self.NormalPlayerWalkSpeed = self.Owner:GetWalkSpeed()
        self.NormalPlayerRunSpeed = self.Owner:GetRunSpeed()

        self.Owner:SetWalkSpeed( self.NormalPlayerWalkSpeed * 0.5 )
        self.Owner:SetRunSpeed( self.NormalPlayerRunSpeed * 0.5 )

    elseif self.NormalPlayerWalkSpeed and self.NormalPlayerRunSpeed then

        self.Owner:SetWalkSpeed( self.NormalPlayerWalkSpeed )
        self.Owner:SetRunSpeed( self.NormalPlayerRunSpeed )

        self.NormalPlayerWalkSpeed = nil
        self.NormalPlayerRunSpeed = nil

    end

end



--[[---------------------------------------------------------
	Name: SWEP:Holster( weapon_to_swap_to )
	Desc: Weapon wants to holster
	RetV: Return true to allow the weapon to holster
-----------------------------------------------------------]]
function SWEP:Holster()

    self:SetOwnerZoomSpeed(false)
    self.LastAmmoCountAppliedRecoil = nil
    self.RecoilShock = Angle( 0, 0, 0 )
    return true

end


function SWEP:CanPrimaryAttack()
    if self.Weapon:GetNetworkedBool( "reloading", false ) then return false end

    if not self.Owner:IsNPC() and not (ACF.SWEP.NoclipShooting or self.Owner:GetMoveType() == MOVETYPE_WALK or self.Owner:InVehicle()) then return false end

    if CurTime() < self.Weapon:GetNextPrimaryFire() then return false end

    if self.Primary.ClipSize < 0 then
        local ammoct = self.Owner:GetAmmoCount( self.Primary.Ammo )
        if ammoct <= 0 then return false end
    else
        local clip = self.Weapon:Clip1()
        if clip <= 0 then
            if self.Owner:IsNPC() then

                return true

            else

                self.Weapon:EmitSound( "acf_sweps_misfire" )
                self:SetNextPrimaryFire( CurTime() + 0.5 )

                return false

            end
        end
    end

    return true

end



function SWEP:SetInaccuracy(add)
    ACF.SWEP.SetInaccuracy(self, add)
end


function SWEP:AddInaccuracy(add)
    ACF.SWEP.AddInaccuracy(self, add)
end



function SWEP:PrimaryAttack()

    if self:CanPrimaryAttack() then

        if self.Weapon:Clip1() > 0 or not self.Owner:IsNPC() then
            self.Weapon:TakePrimaryAmmo(1)
        end

        self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self.Owner:MuzzleFlash()
        self.Owner:SetAnimation( PLAYER_ATTACK1 )

        if SERVER then

            if self.Owner:IsNPC() then
                self.Weapon:EmitSound( self.Primary.TPSound, 100, math.random(90,110) )
            end

            self:FireBullet()

        end

        self:VisRecoil()

        self:AddInaccuracy(self.InaccuracyPerShot)

        self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    end

end



function SWEP:VisRecoil()

    if self:Clip1() == self.LastAmmoCountAppliedRecoil then return end

    if ( (game.SinglePlayer() and SERVER) or ( not game.SinglePlayer() and CLIENT and IsFirstTimePredicted() ) ) then

        local punchScale = ( ( self.BulletMass * 0.1 * self.MuzzleVel ) / ( self.Handling.Mass ) )

        local rnda = ( -punchScale * math.random() ) * 10
        local rndb = ( math.random() * punchScale - punchScale / 2 ) * 10

        if self.RecoilShock == nil then self.RecoilShock = Angle( 0, 0, 0 ) end

        self.RecoilShock = self.RecoilShock + Angle( rnda, rndb, 0 )

    end
end




function SWEP:CalculateVisRecoilScale()

    local moving = self.Owner:KeyDown(IN_FORWARD) or self.Owner:KeyDown(IN_BACK) or self.Owner:KeyDown(IN_MOVELEFT) or self.Owner:KeyDown(IN_MOVERIGHT)
    local crouching = self.Owner:KeyDown(IN_DUCK) or inVehicle
    local zoomed = self:GetNetworkedBool("Zoomed")

    local inacc = 1

    if zoomed then
        if crouching and not moving then
            inacc = 0.5
        elseif not moving then
            inacc = 0.65
        elseif crouching then
            inacc = 0.8
        else
            inacc = 0.8
        end
    elseif crouching then
        inacc = 0.85
    end

    return inacc

end

SWEP.Zoomed = false

function SWEP:SecondaryAttack()

    --[[
	if SERVER and self.HasZoom and self:CanZoom() then
		self:SetZoom()
	end
	--]]
    return false

end



function SWEP:Reload()

    if self.Weapon:GetNetworkedBool( "reloading", false ) then return end

    if self.Zoomed then return false end

    if self:Clip1() < self.Primary.ClipSize and ( self.Owner:IsNPC() or self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then


        if SERVER then
            self.Weapon:SetNetworkedBool( "reloading", true )
            --self.Weapon:SetVar( "reloadtimer", CurTime() + self.ReloadTime )
            timer.Simple(self.ReloadTime, function() if IsValid(self) then self.Weapon:SetNetworkedBool( "reloading", false ) end end)
            self.Weapon:SetNextPrimaryFire(CurTime() + self.ReloadTime)
            --self.Owner:DoReloadEvent()
            self.Owner:SetAnimation( ACT_RELOAD )
        end


        local reloaded = self:DefaultReload( ACT_VM_RELOAD )

        --print("do reload!")

        self:SetInaccuracy(self.MaxInaccuracy)
    end

    self.LastAmmoCountAppliedRecoil = nil

end



function SWEP.randvec(min, max)
    return Vector(	min.x+math.random()*(max.x-min.x),
        min.y+math.random()*(max.y-min.y),
        min.z+math.random()*(max.z-min.z))
end

-- Randomly perturbs a vector within a cone of Degs degrees.
-- Gaussian distribution, NOT uniform!

SWEP.cachedvec = Vector()

function SWEP:inaccuracy(vec, degs)
    local rand = self.randvec(vec, self.cachedvec)
    self.cachedvec = rand:Cross(VectorRand()):GetNormalized()

    local cos = math.cos(math.rad(degs))

    local phi = 2 * math.pi * math.random()
    local z = cos + ( 1 - cos ) * math.random()
    sint = math.sqrt( 1 - z*z )

    return rand * math.cos(phi) * sint + self.cachedvec * math.sin(phi) * sint + vec * z
end



function SWEP:ShootEffects()

    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	-- View model animation
    self.Owner:SetAnimation( PLAYER_ATTACK1 )   -- 3rd Person Animation

end



function SWEP:FireAnimationEvent(pos,ang,event)

    local curtime = CurTime()

    if not self.NextFlash then self.NextFlash = curtime - 0.05 end

    -- Disabled to determine error
    -- firstperson muzzleflash
    if event == 5001 then

        if self.NextFlash > curtime then return true end

        self.NextFlash = curtime + 0.05

        local Effect = EffectData()
        Effect:SetEntity( self )
        --Effect:SetOrigin(pos)
        --Effect:SetAngles(ang)
        Effect:SetScale( self.BulletData["PropMass"] or 1 )
        Effect:SetMagnitude( self.ReloadTime )
        Effect:SetSurfaceProp( ACF.RoundTypes[self.BulletData["Type"]]["netid"] or 1 )	--Encoding the ammo type into a table index
        Effect:SetMaterialIndex(5001) -- flag for effect from animation event
        util.Effect( "ACF_SWEPMuzzleFlash", Effect, true)

        return true

    end

    -- Disable thirdperson muzzle flash
    if ( event == 5003 ) then

        if self.NextFlash > curtime then return true end

        self.NextFlash = curtime + 0.05

        local Effect = EffectData()
        Effect:SetEntity( self )
        Effect:SetOrigin(self:GetAttachment(1).Pos)
        --Effect:SetAngles(ang)
        Effect:SetScale( self.BulletData["PropMass"] or 1 )
        Effect:SetMagnitude( self.ReloadTime )
        Effect:SetSurfaceProp( ACF.RoundTypes[self.BulletData["Type"]]["netid"] or 1 )	--Encoding the ammo type into a table index
        Effect:SetMaterialIndex(5003) -- flag for effect from animation event
        util.Effect( "ACF_SWEPMuzzleFlash", Effect, true)

        return true

    end

    --if ( event == 6002 ) then return true end

end


function SWEP:UpdateTracers(overrideCol)

    if not SERVER then return end

    if overrideCol then

        self.BulletData["Colour"] =	overrideCol

    elseif ACF.SWEP.PlayerTracers and IsValid(self.Owner) then

        local col = self.Owner:GetPlayerColor()
        self.BulletData["Colour"] =	Color(col.r * 255, col.g * 255, col.b * 255)

    end

    self:UpdateFakeCrate()

end
