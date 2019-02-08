
local acfClient_crosshair = CreateClientConVar( "acfsweps_crosshairType", "0", true, false )
local acfClient_fov 	  = CreateClientConVar( "acfsweps_viewmodelFOV", "50", true, false )
local acfClient_hl2cross  = CreateClientConVar( "acfsweps_showHLCrosshair", "0", true, false )

hook.Add( "PopulateToolMenu", "AddonSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "ACF", "acfsweps_config", "ACF-Sweps Config", "", "", function( panel )
		panel:ClearControls()
		
		panel:NumSlider( "Viewmodel FOV", "acfsweps_viewmodelFOV", 30, 90 )
		panel:CheckBox( "Show hl2 crosshair", "acfsweps_showHLCrosshair" )
		
		local Combobox = vgui.Create( 'DComboBox', panel )
		
		Combobox:SetValue( "Crosshair" )
		Combobox:AddChoice( "Half-Life 2" )
		Combobox:AddChoice( "Radial" )
		Combobox:AddChoice( "Cross" )
		Combobox:SizeToContents()
		
		Combobox.OnSelect = function( panel, index, value )
			GetConVar("acfsweps_crosshairType"):SetString( value )
		end
		
		--lb_Crosshair
		
	end )
end )
