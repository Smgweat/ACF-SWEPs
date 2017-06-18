// Credit to Bubbus for all the hard work, I just changed the easy stuff.

AddCSLuaFile( "shared.lua" )
SWEP.HoldType	= "pistol"

if (CLIENT) then
	SWEP.Slot			= 1
	SWEP.DrawCrosshair	= false
	SWEP.Author			= "Alexander"
	SWEP.PrintName		= "Desert Eagle"
	SWEP.Purpose		= "Large Cartridge Hand-Gun"
	SWEP.Instructions	= ""
end

SWEP.Base			= "weapon_acf_base"
SWEP.ViewModelFlip	= false
SWEP.ViewModelFOV	= 50

SWEP.Spawnable		= true
SWEP.AdminSpawnable	= false
SWEP.Category		= "ACF"
SWEP.ViewModel		= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_deagle.mdl"

SWEP.UseHands = true

SWEP.Weight			= 4.4
SWEP.AutoSwitchTo	= false
SWEP.AutoSwitchFrom	= false

SWEP.Primary.Recoil			= 1
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.6
SWEP.Primary.DefaultClip 	= SWEP.Primary.ClipSize * 3 // Number of mags available
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9mmRound"
SWEP.Primary.Sound			= "weapons/acf_swep/weapon_acf_deagle.wav"

SWEP.ReloadTime	= 2

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

//Muzzle-Flash Offset
SWEP.AimOffset = Vector(30, 8, -6)

SWEP.HasZoom 			= true
SWEP.HasScope 			= false
SWEP.ZoomInaccuracyMod	= 0.4
SWEP.ZoomDecayMod 		= 1.2
SWEP.ZoomFOV 			= 65

SWEP.IronSights 	= true
SWEP.IronSightsPos 	= Vector(-6, 6.385, 2.1) // Depth, Horizontal, Vertical
SWEP.ZoomPos 		= Vector(2,-2,2)
SWEP.IronSightsAng 	= Angle(-0.21, -0.04, 0) // Pitch, Yaw, Roll

SWEP.MinInaccuracy 			= 1.5
SWEP.MaxInaccuracy 			= 6
SWEP.Inaccuracy 			= SWEP.MaxInaccuracy
SWEP.InaccuracyDecay 		= 1 / SWEP.Weight
SWEP.AccuracyDecay 			= 0.04
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

	// .45 ACP Full Metal Jacket

	local GunType 		= "Pistol" // Rifle, Pistol
	local Ammunition 	= "HP" // Ammunition type
	local Caliber 		= 1.27 // Diameter in cm
	local Length 		= 4.0 // in cm
	local MuzzleVel 	= 470 // Speed of the fired bullet
	local BulletMass 	= 19 // Weight in Grams

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