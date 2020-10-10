
resource.AddFile( "materials/vgui/entities/weapon_acf_m249.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot		= 3						-- Slot in the weapon selection menu
    SWEP.SlotPos	= 10					-- Position in the slot

    killicon.AddFont( "weapon_acf_m249", "CSSD_Killcon", "z", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/m249" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName = "M249 SAW" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base = "weapon_acf_base"

    SWEP.HoldType   = "ar2"
    SWEP.ViewModel  = "models/weapons/cstrike/c_mach_m249para.mdl"
    SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo = "ar2"

    sound.Add( {
        name = "ACF_SWEP_m249",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = ")weapons/m249/m249-1.wav"
    } )

    SWEP.Primary.Sound = "ACF_SWEP_m249"
    SWEP.Primary.TPSound = "ACF_SWEP_m249"

    SWEP.Primary.Delay = 60 / 700
    SWEP.Primary.ClipSize = 200
    SWEP.Primary.DefaultClip = 400
    SWEP.Primary.Automatic = true

    SWEP.ReloadTime = 4.5

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass	   = 9100 	-- Weight in grams
    SWEP.Handling.Barrel   = 893 	-- Barrel length in milimeters
    SWEP.Handling.Balance  = 10 	-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom  = false
    SWEP.HasScope = false
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition ( 5.56×45mm NATO )
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType 	= "Rifle" 	-- For bullet length approximation
    SWEP.Caliber 	= 5.56 		-- Diameter in milimeters
    SWEP.Length 	= 45 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel 	= 915 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 4 		-- Weight in Grams ( Not grains! )

end

