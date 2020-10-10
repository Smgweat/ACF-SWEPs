
resource.AddFile( "vgui/entities/weapon_acf_iws.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot	= 3						-- Slot in the weapon selection menu
    SWEP.SlotPos = 12					-- Position in the slot

    killicon.AddFont( "weapon_acf_awp", "CSSD_Killcon", "r", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/awp" )
    SWEP.IconOverride = "entities/awp_icon.png"

    SWEP.UseHands = false

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName = "IWS 2000" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base = "weapon_acf_base"

    SWEP.HoldType = "crossbow"
    SWEP.ViewModel = "models/weapons/v_sniper.mdl"
    SWEP.WorldModel = "models/weapons/w_sniper.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo = "XBowBolt"

    sound.Add( {
        name = "ACF_SWEP_iws",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 500,
        pitch = { 95, 110 },
        sound = ")weapons/amr/sniper_fire.wav"
    } )

    SWEP.Primary.Sound 	 = "ACF_SWEP_iws"
    SWEP.Primary.TPSound = "ACF_SWEP_iws"

    SWEP.Primary.Delay = 1.6
    SWEP.Primary.ClipSize = 1
    SWEP.Primary.DefaultClip = 2
    SWEP.Primary.Automatic = false

    SWEP.ReloadTime = 3

    SWEP.Launcher = false

    SWEP.AimOffset = Vector( 32, 8, -1 )

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass = 18000 	-- Weight in grams
    SWEP.Handling.Barrel = 1200	-- Barrel length in milimeters
    SWEP.Handling.Balance = 1 	-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom = true
    SWEP.HasScope = true
    SWEP.IronSights = true
    SWEP.IronSightsPos = Vector(0, 6.02, 2.87)
    SWEP.ZoomPos = Vector(2,-2,2)
    SWEP.IronSightsAng = Angle(0.4, -0.16, 0)
    SWEP.ZoomFOV = 16

    -- Ammunition ( AP Sabot )
    SWEP.Ammunition	= "AP" 		-- Ammunition type
    SWEP.GunType = "Rifle" 	    -- For bullet length approximation
    SWEP.Caliber = 15.2 		-- Diameter in milimeters
    SWEP.Length = 169 		    -- Case length in milimeters, The bullet length is estimated
    SWEP.MuzzleVel = 1450 		-- Speed of the fired bullet in meters per second
    SWEP.BulletMass = 150 		-- Weight in Grams ( Not grains! )

    --[[
    function SWEP:InitBulletData()
	
        self.BulletData = {}
        
        self.BulletData["Accel"]		= Vector(0.000000, 0.000000, -600.000000)
        self.BulletData["BoomPower"]		= 5.9354922528
        self.BulletData["Caliber"]		= 8
        self.BulletData["Colour"]		= Color(255, 255, 255)
        self.BulletData["DetonatorAngle"]		= 80
        self.BulletData["DragCoef"]		= 0.00027827729001115
        self.BulletData["FillerMass"]		= 4.93581
        self.BulletData["FrAera"]		= 50.2656
        self.BulletData["Id"]		= "Strela-1 SAM"
        self.BulletData["KETransfert"]		= 0.1
        self.BulletData["LimitVel"]		= 100
        self.BulletData["MuzzleVel"]		= 340.91341073442
        self.BulletData["PenAera"]		= 27.930598395101
        self.BulletData["ProjLength"]		= 92.57
        self.BulletData["ProjMass"]		= 18.0631340768
        self.BulletData["PropLength"]		= 12.43
        self.BulletData["PropMass"]		= 0.9996822528
        self.BulletData["Ricochet"]		= 60
        self.BulletData["RoundVolume"]		= 5277.888
        self.BulletData["ShovePower"]		= 0.1
        self.BulletData["Tracer"]		= 0
        self.BulletData["Type"]		= "HE"

        
    
    end
    ]]

end

