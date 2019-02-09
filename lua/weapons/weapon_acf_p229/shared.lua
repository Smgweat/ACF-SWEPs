
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot		= 1						-- Slot in the weapon selection menu
    SWEP.SlotPos	= 10					-- Position in the slot

    killicon.AddFont( "weapon_acf_p229", "CSSD_Killcon", "a", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/p228" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName		= "SIG P229" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base 	  = "weapon_acf_base"

    SWEP.HoldType 		= "pistol"
    SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_p228.mdl"
    SWEP.WorldModel 	= "models/weapons/w_pist_p228.mdl"

    SWEP.Spawnable		= true
    SWEP.AdminSpawnable	= false
    SWEP.Category		= "ACF"

    SWEP.Primary.Ammo 		 = "pistol"

    sound.Add( {
        name = "ACF_SWEP_p229",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = "^weapons/p228/p228-1.wav"
    } )

    SWEP.Primary.Sound 	   	 = "ACF_SWEP_p229"
    SWEP.Primary.TPSound   	 = "ACF_SWEP_p229"

    SWEP.Primary.Delay		 = 0.1
    SWEP.Primary.ClipSize 	 = 8
    SWEP.Primary.DefaultClip = 16
    SWEP.Primary.Automatic 	 = false

    SWEP.ReloadTime = 1.6

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass	   = 905 	-- Weight in grams
    SWEP.Handling.Barrel   = 99 	-- Barrel length in milimeters
    SWEP.Handling.Balance  = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom  = false
    SWEP.HasScope = false
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition ( .357 SIG )
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType 	= "Pistol" 	-- For bullet length approximation
    SWEP.Caliber 	= 9 		-- Diameter in milimeters
    SWEP.Length 	= 22 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel 	= 410 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 8.1 		-- Weight in Grams ( Not grains! )

end

