if (!PCTool) then include( "pcmod/sh_tool.lua" ) end

TOOL.Name = "Server"
TOOL.Class = "pcspawn_server"
TOOL.Desc = "Spawns a server"
TOOL.Inst = {
	{ "Spawn a server" }
}

TOOL.ModelList = {
	"models/props/de_nuke/equipment1.mdl",
	"models/props/cs_office/computer_case.mdl"
}

TOOL.Type = "spawner"
TOOL.SpawnType = "Networking"

TOOL.EntName = "Server"
TOOL.EntClass = "pcmod_server"
TOOL.DefaultMax = 8
TOOL.Model = "models/props/de_nuke/equipment1.mdl"

local dat = PCTool.RegisterSTool( TOOL )
table.Merge( TOOL, dat )

TOOL.ClientConVar[ "os" ] = "server"

if (SERVER) then

	function TOOL:BuildSetupData()
		local tmp = {}
			local OS = self:GetClientInfo( "os" )
			if ( (OS == "server") ) then
				tmp.OS = OS
				tmp.BootCommand = "os:instance\nos:launch"
			else
				tmp.OS = ""
				tmp.BootCommand = "waitcommand"
			end	
		return tmp
	end

end

if (CLIENT) then

	function TOOL.BuildCPanel( panel )
		local pf = "Tool_pcspawn_tower_"
	
		// Header
		panel:AddControl( "Header", { Text = "Server", Description = "Spawns a PCMod Server" } )
		
		// Model select
		panel:AddControl( "PropSelect", { 
			Label = "Model:",
			ConVar = "pcspawn_tower_model",
			Category = "pcmod",
			Models = list.Get( "mdls_pcspawn_server" ) 
		} )
							
		// Operating System Selection
		panel:AddControl( "ComboBox", { 
			Label = "Operating System:",
			ConVar = "pcspawn_tower_os",
			Category = "pcmod",
			Options = { Server = { pcspawn_tower_os = "server" } } 
		} )
	end
	
end