
resource.AddFile( "vgui/entities/weapon_acf_galil.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot = 2						-- Slot in the weapon selection menu
    SWEP.SlotPos = 10					-- Position in the slot

    killicon.AddFont( "weapon_acf_galil", "CSSD_Killcon", "v", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/galil" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName = "IMI Galil ARM" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base = "weapon_acf_base"

    SWEP.HoldType = "ar2"
    SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
    SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo = "ar2"

    sound.Add( {
        name = "ACF_SWEP_galil",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = ")weapons/galil/galil-1.wav"
    } )

    SWEP.Primary.Sound = "ACF_SWEP_galil"
    SWEP.Primary.TPSound = "ACF_SWEP_galil"

    SWEP.Primary.Delay = 0.07
    SWEP.Primary.ClipSize = 30
    SWEP.Primary.DefaultClip = 60
    SWEP.Primary.Automatic = true

    SWEP.ReloadTime = 1.5

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass = 4450 	-- Weight in grams
    SWEP.Handling.Barrel = 535 	-- Barrel length in milimeters
    SWEP.Handling.Balance = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom = false
    SWEP.HasScope = false
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition ( 5.56×45mm NATO )
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType = "Rifle" 	-- For bullet length approximation
    SWEP.Caliber = 5.56 		-- Diameter in milimeters
    SWEP.Length = 45 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel = 850 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 4 		-- Weight in Grams ( Not grains! )

end

