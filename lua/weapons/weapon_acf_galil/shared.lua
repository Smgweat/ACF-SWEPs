// Credit to Bubbus for all the hard work, I just changed the easy stuff.

AddCSLuaFile( "shared.lua" )
SWEP.HoldType	= "ar2"

if (CLIENT) then
	SWEP.Slot			= 3
	SWEP.DrawCrosshair	= false
	SWEP.Author			= "Alexander"
	SWEP.PrintName		= "Galil AR"
	SWEP.Purpose		= "Israeli Military Combat Rifle"
	SWEP.Instructions	= ""
end

SWEP.Base			= "weapon_acf_base"
SWEP.ViewModelFlip	= false
SWEP.ViewModelFOV	= 50

SWEP.Spawnable		= true
SWEP.AdminSpawnable	= false
SWEP.Category		= "ACF"
SWEP.ViewModel		= "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_galil.mdl"

SWEP.UseHands = true

SWEP.Weight			= 7.7
SWEP.AutoSwitchTo	= false
SWEP.AutoSwitchFrom	= false

SWEP.Primary.Recoil			= 6
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.14
SWEP.Primary.DefaultClip 	= SWEP.Primary.ClipSize * 2 // Number of mags available
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"
SWEP.Primary.Sound			= "weapons/acf_swep/weapon_acf_galil.wav"

SWEP.ReloadTime	= 3

SWEP.Secondary.ClipSize	 	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

//Muzzle-Flash Offset
SWEP.AimOffset = Vector(30, 8, -6)

SWEP.HasZoom 			= true
SWEP.HasScope 			= false
SWEP.ZoomInaccuracyMod 	= 0.4
SWEP.ZoomDecayMod 		= 1.2
SWEP.ZoomFOV 			= 65

SWEP.IronSights 	= true
SWEP.IronSightsPos 	= Vector(-6, 6.37, 2.5)
SWEP.ZoomPos 		= Vector(2,-2,2)
SWEP.IronSightsAng 	= Angle(-0.1, -0.04, 0)

SWEP.MinInaccuracy 			= 1.5
SWEP.MaxInaccuracy 			= 6
SWEP.Inaccuracy 			= SWEP.MaxInaccuracy
SWEP.InaccuracyDecay 		= 0.077
SWEP.AccuracyDecay			= 0.06
SWEP.InaccuracyPerShot 		= 1.8
SWEP.InaccuracyCrouchBonus 	= 1.5
SWEP.InaccuracyDuckPenalty 	= 6

SWEP.Stamina 			= 1
SWEP.StaminaDrain 		= 0.005 / 1
SWEP.StaminaJumpDrain 	= 0.1

SWEP.Class 		= "MG"
SWEP.FlashClass = "MG"
SWEP.Launcher 	= false
SWEP.AlwaysDust = false

SWEP.RecoilScale 	= 0.25
SWEP.RecoilDamping 	= 0.16

function SWEP:InitBulletData()

	// 7.62x51 NATO Full Metal Jacket

	local GunType 		= "Rifle" // Rifle, Pistol
	local Ammunition	= "AP" // Ammunition type
	local Caliber 		= 0.762 // Diameter in cm
	local Length 		= 51 // in cm
	local MuzzleVel 	= 850 // Speed of the fired bullet
	local BulletMass 	= 10 // Weight in Grams

	if GunType == "Rifle" then
		Length = Length * 0.46
	elseif GunType == "Pistol" then
		Length = Length * 0.52
	end

	local FrontArea
	//local BulletVolume = Length * FrontArea

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

	self.BulletData["Id"]					= "7.62mmMG" // You could literally put anything here.
	self.BulletData["Caliber"]				= Caliber // !!
	self.BulletData["Colour"]				= Color(255, 255, 255)
	self.BulletData["DragCoef"]				= ( FrontArea / 10000 ) / ( BulletMass/1000 )
	self.BulletData["FrAera"]				= FrontArea // !!
	self.BulletData["LimitVel"]				= 800
	self.BulletData["MuzzleVel"]			= MuzzleVel // !!
	self.BulletData["KETransfert"]			= 0.1 // "Trasnfert" - Nice.
	self.BulletData["PenAera"]				= FrontArea^0.85 // !!  "Aera" - Also nice.
	self.BulletData["ProjLength"]			= Length // !!
	self.BulletData["ProjMass"]				= BulletMass/1000 // !!
	self.BulletData["RoundVolume"]			= Length * FrontArea // !!
	self.BulletData["Type"]		    		= Ammunition
	self.BulletData["InvalidateTraceback"]	= true

end