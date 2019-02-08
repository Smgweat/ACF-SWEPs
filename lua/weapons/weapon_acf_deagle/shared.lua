
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

	SWEP.Slot		= 1						-- Slot in the weapon selection menu
	SWEP.SlotPos	= 12					-- Position in the slot

	killicon.AddFont( "weapon_acf_deagle", "CSSD_Killcon", "f", Color( 255, 80, 0, 255 ) )
	
	SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/deserteagle" )
	
end

if SERVER then -- Server only variables

	-- Nothing here!

end

if true then -- Shared variables

	SWEP.PrintName		= "Desert Eagle XIX" -- 'Nice' Weapon name (Shown on HUD)
	
	SWEP.Base 	  = "weapon_acf_base"
	
	SWEP.HoldType 		= "pistol"
	SWEP.ViewModel 		= "models/weapons/cstrike/c_pist_deagle.mdl"
	SWEP.WorldModel 	= "models/weapons/w_pist_deagle.mdl"

	SWEP.Spawnable		= true
	SWEP.AdminSpawnable	= false
	SWEP.Category		= "ACF"

	SWEP.Primary.Ammo 		 = "pistol"
	
	sound.Add( {
		name = "ACF_SWEP_deag",
		channel = CHAN_WEAPON,
		volume = VOL_NORM,
		level = 500,
		pitch = { 95, 110 },
		sound = "^weapons/acf_swep/acf_deag.wav"
	} )
	
	SWEP.Primary.Sound 	   	 = "ACF_SWEP_deag"
	SWEP.Primary.TPSound   	 = "ACF_SWEP_deag"
	
	SWEP.Primary.Delay		 = 0.25
	SWEP.Primary.ClipSize 	 = 12
	SWEP.Primary.DefaultClip = 24
	SWEP.Primary.Automatic 	 = false
	
	SWEP.ReloadTime = 1.6
	
	SWEP.Launcher = false
	
	SWEP.AimOffset = Vector(32, 8, -1)
	
	-- Gun statistics
	SWEP.Handling = {}
	SWEP.Handling.Mass	   = 1999 	-- Weight in grams
	SWEP.Handling.Barrel   = 152 	-- Barrel length in milimeters
	SWEP.Handling.Balance  = 1 		-- Recoil multiplier for this weapon
	
	-- Sight Options
	SWEP.HasZoom  = false
	SWEP.HasScope = false
	SWEP.IronSights = true
	SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
	SWEP.ZoomPos = Vector(2,-2,2)
	SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
	SWEP.ZoomFOV  = 50
	
	-- Ammunition ( .44 Magnum )
	SWEP.Ammunition	= "HP" 		-- Ammunition type
	SWEP.GunType 	= "Pistol" 	-- For bullet length approximation
	SWEP.Caliber 	= 10.9 		-- Diameter in milimeters
	SWEP.Length 	= 33 		-- Case length in milimeters, The bullet length is estimated
	SWEP.MuzzleVel 	= 434 		-- Speed of the fired bullet in meters per second
	SWEP.BulletMass = 22 		-- Weight in Grams ( Not grains! )
	
end

