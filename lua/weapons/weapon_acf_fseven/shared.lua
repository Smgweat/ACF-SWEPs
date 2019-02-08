
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

	SWEP.Slot		= 1						-- Slot in the weapon selection menu
	SWEP.SlotPos	= 11					-- Position in the slot

	killicon.AddFont( "weapon_acf_fseven", "CSSD_Killcon", "u", Color( 255, 80, 0, 255 ) )
	
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/fiveseven" )
	
end

if SERVER then -- Server only variables

	-- Nothing here!

end

if true then -- Shared variables

	SWEP.PrintName		= "FN Five-seveN" -- 'Nice' Weapon name (Shown on HUD)
	
	SWEP.Base 	  = "weapon_acf_base"
	
	SWEP.HoldType 		= "pistol"
	SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_fiveseven.mdl"
	SWEP.WorldModel 	= "models/weapons/w_pist_fiveseven.mdl"

	SWEP.Spawnable		= true
	SWEP.AdminSpawnable	= false
	SWEP.Category		= "ACF"

	SWEP.Primary.Ammo 	= "pistol"
	
	sound.Add( {
		name = "ACF_SWEP_fseven",
		channel = CHAN_WEAPON,
		volume = VOL_NORM,
		level = 500,
		pitch = { 95, 110 },
		sound = "^weapons/acf_swep/acf_fseven.wav"
	} )
	
	SWEP.Primary.Sound 	   	 = "ACF_SWEP_fseven"
	SWEP.Primary.TPSound   	 = "ACF_SWEP_fseven"

	SWEP.Primary.Delay		 = 0.1
	SWEP.Primary.ClipSize 	 = 20
	SWEP.Primary.DefaultClip = 40
	SWEP.Primary.Automatic 	 = false
	
	SWEP.ReloadTime = 1.6
	
	SWEP.Launcher = false
	
	SWEP.AimOffset = Vector(32, 8, -1)
	
	-- Gun statistics
	SWEP.Handling = {}
	SWEP.Handling.Mass	   = 610 	-- Weight in grams
	SWEP.Handling.Barrel   = 122 	-- Barrel length in milimeters
	SWEP.Handling.Balance  = 1 		-- Recoil multiplier for this weapon
	
	-- Sight Options
	SWEP.HasZoom  = false
	SWEP.HasScope = false
	SWEP.IronSights = true
	SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
	SWEP.ZoomPos = Vector(2,-2,2)
	SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
	SWEP.ZoomFOV  = 50
	
	-- Ammunition ( FN 5.7×28mm )
	SWEP.Ammunition	= "AP" 		-- Ammunition type
	SWEP.GunType 	= "Rifle" 	-- For bullet length approximation
	SWEP.Caliber 	= 5.7 		-- Diameter in milimeters
	SWEP.Length 	= 28 		-- Case length in milimeters, The bullet length is estimated
	SWEP.MuzzleVel 	= 716 		-- Speed of the fired bullet in meters per second
	SWEP.BulletMass = 2 		-- Weight in Grams ( Not grains! )
	
end

