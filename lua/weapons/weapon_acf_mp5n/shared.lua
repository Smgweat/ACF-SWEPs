
resource.AddFile( "vgui/entities/weapon_acf_mp5n.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot		= 2						-- Slot in the weapon selection menu
    SWEP.SlotPos	= 10					-- Position in the slot

    killicon.AddFont( "weapon_acf_mp5n", "CSSD_Killcon", "x", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/mp5" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName		= "H&K MP5N" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base 	  = "weapon_acf_base"

    SWEP.HoldType 		= "smg"
    SWEP.ViewModel 		= "models/weapons/cstrike/c_smg_mp5.mdl"
    SWEP.WorldModel 	= "models/weapons/w_smg_mp5.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo 	= "smg1"

    sound.Add( {
        name = "ACF_SWEP_mp5n",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = "^weapons/mp5navy/mp5-1.wav"
    } )

    SWEP.Primary.Sound 	   	 = "ACF_SWEP_mp5n"
    SWEP.Primary.TPSound   	 = "ACF_SWEP_mp5n"

    SWEP.Primary.Delay		 = 0.075
    SWEP.Primary.ClipSize 	 = 30
    SWEP.Primary.DefaultClip = 60
    SWEP.Primary.Automatic 	 = true

    SWEP.ReloadTime = 1.5

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass	   = 2500 	-- Weight in grams
    SWEP.Handling.Barrel   = 225 	-- Barrel length in milimeters
    SWEP.Handling.Balance  = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom  = false
    SWEP.HasScope = false
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition ( 9×19mm Parabellum )
    SWEP.Ammunition	= "HP" 		-- Ammunition type
    SWEP.GunType 	= "Pistol" 	-- For bullet length approximation
    SWEP.Caliber 	= 9 		-- Diameter in milimeters
    SWEP.Length 	= 19 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel 	= 400 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 7.45 		-- Weight in Grams ( Not grains! )

end

