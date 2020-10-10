
resource.AddFile( "materials/vgui/entities/weapon_acf_awp.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot	= 3						-- Slot in the weapon selection menu
    SWEP.SlotPos = 12					-- Position in the slot

    killicon.AddFont( "weapon_acf_awp", "CSSD_Killcon", "r", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/awp" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName = "L118A1 AWP" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base = "weapon_acf_base"

    SWEP.HoldType = "crossbow"
    SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"
    SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo = "XBowBolt"

    sound.Add( {
        name = "ACF_SWEP_awp",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = ")weapons/awp/awp1.wav"
    } )

    SWEP.Primary.Sound 	   	 = "ACF_SWEP_awp"
    SWEP.Primary.TPSound   	 = "ACF_SWEP_awp"

    SWEP.Primary.Delay = 1.6
    SWEP.Primary.ClipSize = 10
    SWEP.Primary.DefaultClip = 20
    SWEP.Primary.Automatic = false

    SWEP.ReloadTime = 3.6

    SWEP.Launcher = false

    SWEP.AimOffset = Vector( 32, 8, -1 )

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass = 6500 	-- Weight in grams
    SWEP.Handling.Barrel = 660 	-- Barrel length in milimeters
    SWEP.Handling.Balance = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom = true
    SWEP.HasScope = true
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV = 20

    -- Ammunition ( 7.62x51 NATO )
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType = "Rifle" 	    -- For bullet length approximation
    SWEP.Caliber = 7.62 		-- Diameter in milimeters
    SWEP.Length = 51 		    -- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel = 850 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 22 		-- Weight in Grams ( Not grains! )

end

