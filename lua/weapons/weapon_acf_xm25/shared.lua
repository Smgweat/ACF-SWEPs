
resource.AddFile( "vgui/entities/weapon_acf_xm25.vmt" )
AddCSLuaFile( "shared.lua" )

if CLIENT then -- Client only variables

    SWEP.Slot	= 3						-- Slot in the weapon selection menu
    SWEP.SlotPos = 12					-- Position in the slot

    killicon.AddFont( "weapon_acf_awp", "CSSD_Killcon", "r", Color( 255, 80, 0, 255 ) )

    SWEP.WepSelectIcon = surface.GetTextureID( "vgui/gfx/vgui/fav_weap/awp" )

    SWEP.UseHands = false

end

if SERVER then -- Server only variables

-- Nothing here!

end

if true then -- Shared variables

    SWEP.PrintName = "XM25" -- 'Nice' Weapon name (Shown on HUD)

    SWEP.Base = "weapon_acf_base"

    SWEP.HoldType = "crossbow"
    SWEP.ViewModel = "models/weapons/v_xm25.mdl"
    SWEP.WorldModel = "models/weapons/w_xm25.mdl"

    SWEP.Spawnable = true
    SWEP.AdminSpawnable	= false
    SWEP.Category	= "ACF"

    SWEP.Primary.Ammo = "SMG1_Grenade"

    sound.Add( {
        name = "ACF_SWEP_xm25",
        channel = CHAN_WEAPON,
        volume = VOL_NORM,
        level = 80,
        pitch = { 95, 110 },
        sound = ")weapons/grenade_launcher1.wav"
    } )

    SWEP.Primary.Sound 	   	 = "ACF_SWEP_xm25"
    SWEP.Primary.TPSound   	 = "ACF_SWEP_xm25"

    SWEP.Primary.Delay = 1.6
    SWEP.Primary.ClipSize = 5
    SWEP.Primary.DefaultClip = 10
    SWEP.Primary.Automatic = false

    SWEP.ReloadTime = 3.6

    SWEP.Launcher = false

    SWEP.AimOffset = Vector( 32, 8, -1 )

    -- Gun statistics
    SWEP.Handling = {}
    SWEP.Handling.Mass = 6350 	-- Weight in grams
    SWEP.Handling.Barrel = 450 	-- Barrel length in milimeters
    SWEP.Handling.Balance = 1 		-- Recoil multiplier for this weapon

    -- Sight Options
    SWEP.HasZoom = true
    SWEP.ZoomFOV = 10

    -- Custom Ammunition
    function SWEP:InitBulletData()
	
        self.BulletData = {}
        
        self.BulletData["Accel"] = Vector( 0.000000, 0.000000, -600.000000 )
        self.BulletData["BoomPower"] = 0.09550192653132
        self.BulletData["Caliber"] = 4
        self.BulletData["Colour"] = Color( 255, 255, 255 )
        self.BulletData["DetonatorAngle"] = 80
        self.BulletData["DragCoef"]	= 0.0053551695179568
        self.BulletData["FillerMass"] = 0.09530086413132
        self.BulletData["FrAera"] = 12.5664
        self.BulletData["Id"] = "40mmGL"
        self.BulletData["KETransfert"] = 0.1
        self.BulletData["LimitVel"]	= 100
        self.BulletData["MuzzleVel"] = 210
        self.BulletData["PenAera"] = 8.5966500438773
        self.BulletData["ProjLength"] = 6
        self.BulletData["ProjMass"]	= 0.23465923829046
        self.BulletData["PropLength"] = 0.01
        self.BulletData["PropMass"]	= 0.0002010624
        self.BulletData["Ricochet"]	= 60
        self.BulletData["RoundVolume"] = 75.524064
        self.BulletData["ShovePower"] = 0.1
        self.BulletData["Tracer"] = 1.25
        self.BulletData["Type"] = "HE"
        
    
    end

end

