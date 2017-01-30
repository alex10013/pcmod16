
// PCMod ScreenSpace Device | Open File (Basic) \\

DEV.Name = "window_openfile"

DEV.LastTick = 0
DEV.LastFrame = 0

DEV.Th = "basic"
DEV.Fs = {}
 
net.Receive( 'EntityBilgi', function()
entoku = net.ReadEntity()
tablooku = net.ReadTable()
entoku.Tablom = tablooku
end)
 
function DEV:Initialize( x, y, w, h )
	if (self.Entity:GetClass() == pcmod_laptop) then
	bunubelirles = self.Entity.Tablom
	else
	bunubelirles = entoku.Tablom
	end
	// Make exit button
	self:CreateButton2( self.Th, "btnExit", (x+w)-(h*0.1), y, h*0.1, h*0.1, "X" )
	
	// Create the listbox
	self:CreateListbox( self.Th, "lstFiles", x+(w*0.02), y+(h*0.12), w*0.96, h*0.76 )
	--analiz = 0
	--PrintTable(self.Entity.Bilgi)
	local saydirguzelim = table.Count(bunubelirles)
	
	/*	for k, v in pairs( self.Fs ) do
		if (v == "Empty") then
		analiz = 1
		end
		end*/

	--if analiz == 0 then
	for k, v in pairs( self.Fs ) do
	for i=0 , saydirguzelim do
	if (bunubelirles[i] == v) then
		self:AddListboxItem( "lstFiles", v, v )
	end
	end
	end
	--end
	// Make the open button
	self:CreateButton2( self.Th, "btnOpen", x+(w*0.02), y+(h*0.9), w*0.96, h*0.08, "Select" )
	
	// Record window data
	self.WinX = x
	self.WinY = y
	self.WinW = w
	self.WinH = h
end

function DEV:Paint( x, y, w, h )
	self:RenderWindow( self.Th, x, y, w, h, "Open File", h*0.1 )
	self:Draw()
end

function DEV:ButtonClick( btn )
	if (btn == "btnExit") then
		self:PassData( self.Parent, "runcommand", "closebrowse" )
	end
	if (btn == "btnOpen") then
		local fl = self:GetListboxSelRow( "lstFiles" )
		if ((fl) && (fl != "")) then
			self:PassData( self.Parent, "filename", fl )
			self:PassData( self.Parent, "runcommand", "closebrowse" )
		end
	end
end

function DEV:DoClick( x, y )
	self:ProcessClick( x, y )
end

function DEV:Tick()
	self.LastTick = CurTime()
	self.LastFrame = PCMod.SDraw.CFrame
end

function DEV:Kill()
	
end

function DEV:KeyPress( key, txt )
	self:KeyPressTextboxes( key, txt )
end