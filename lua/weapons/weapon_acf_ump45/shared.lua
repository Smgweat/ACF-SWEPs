
resource.AddFile( "materials/vgui/entities/weapon_acf_ump45.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot		= 2						-- Slot in the weapon selection menu
    SWEP.SlotPos	= 10					-- Position in the slot

    killicon.AddFont( "weapon_acf_ump45", "CSSD_Killcon", "q", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/ump45" )

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName		= "H&K UMP45" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base 	  = "weapon_acf_base"

    SWEP.HoldType 		= "smg"
    SWEP.ViewModel 		= "models/weapons/cstrike/c_smg_ump45.mdl"
    SWEP.WorldModel 	= "models/weapons/w_smg_ump45.mdl"

    SWEP.Spawnable		= true

    SWEP.Primary.Ammo 		 = "smg1"

    sound.Add( {
        name = "ACF_SWEP_ump45",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = "^weapons/ump45/ump45-1.wav"
    } )

    SWEP.Primary.Sound 	   	 = "ACF_SWEP_ump45"
    SWEP.Primary.TPSound   	 = "ACF_SWEP_ump45"

    SWEP.Primary.Delay		 = 0.1
    SWEP.Primary.ClipSize 	 = 25
    SWEP.Primary.DefaultClip = 50
    SWEP.Primary.Automatic 	 = true

    SWEP.ReloadTime = 1.5

    SWEP.Launcher = false

    SWEP.AimOffset = Vector(32, 8, -1)

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass	   = 2300 	-- Weight in grams
    SWEP.Handling.Barrel   = 200 	-- Barrel length in milimeters
    SWEP.Handling.Balance  = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom  = false
    SWEP.HasScope = false
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV  = 50

    -- Ammunition ( .45 ACP )
    SWEP.Ammunition	= "HP" 		-- Ammunition type
    SWEP.GunType 	= "Pistol" 	-- For bullet length approximation
    SWEP.Caliber 	= 11.43 	-- Diameter in milimeters
    SWEP.Length 	= 23 		-- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel 	= 285 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 15 		-- Weight in Grams ( Not grains! )

end

