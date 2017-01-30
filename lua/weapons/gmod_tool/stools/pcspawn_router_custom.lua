if (!PCTool) then include( "pcmod/sh_tool.lua" ) end

TOOL.Name = "Custom Router"
TOOL.Class = "pcspawn_router"
TOOL.Desc = "Spawns a custom router"
TOOL.Inst = {
	{ "Spawn a custom router" }
}

TOOL.ModelList = {
	"models/props_lab/reciever01a.mdl",
	"models/PCMod/wrt54g.mdl"
}

TOOL.Type = "spawner"
TOOL.SpawnType = "Networking"

TOOL.EntName = "Custom Router"
TOOL.EntClass = "pcmod_router_custom"
TOOL.DefaultMax = 8
TOOL.Model = TOOL.ModelList[ 1 ]

local dat = PCTool.RegisterSTool( TOOL )
table.Merge( TOOL, dat )

TOOL.ClientConVar[ "wireless" ] = 0

if (SERVER) then

	function TOOL:BuildSetupData()
		return { Wireless = (self:GetClientNumber( "wireless" ) == 1)}
	end

end

if (CLIENT) then

	function TOOL.BuildCPanel( panel )
		local pf = "Tool_pcspawn_router_"
	
		// Header
		panel:AddControl( "Header", { Text = "#" .. pf .. "name", Description = "#" .. pf .. "desc" } )
		
		// Model select
		panel:AddControl( "PropSelect", { Label = "Model:",
							ConVar = "pcspawn_router_model",
							Category = "pcmod",
							Models = list.Get( "mdls_pcspawn_router" ) } )
							
		// Wireless option
		panel:AddControl( "CheckBox", { Label = "Wireless:",
							Description = "Enable Wireless",
							Command = "pcspawn_router_wireless" } )
	end
	
end

// I suggest any people looking to learn to make STools do NOT look and learn from this code, it is not the conventional way of doing it. -thomasfn