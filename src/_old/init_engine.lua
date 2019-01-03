function initGraphics()
	--Set scaling filter to "nearest"
	love.graphics.setDefaultFilter("nearest","nearest")
	--Define graphical layers: BG1-BG5
	bgLayer = 
	{
		{}, --BG1 - Lowermost Layer, Drawn First
		{}, --BG2
		{}, --BG3
		{}, --BG4
		{}  --BG5 - Uppermost Layer, Drawn Last
	}	
end

function initUI()
	--Define UI resource path
	UIGraphicsPath = "gfx/UI/"
	
	--Define font table and set inital game font
	fontPath = "fonts/"
	fontTable = 
	{
		{"text_std_vwf_main.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!,."}
	}
	selectFont(UIGraphicsPath..fontPath, fontTable[1][1], fontTable[1][2])
	
	--Define inital textbox settings and initialize textbox "stack"
	textboxGraphicsPath = "boxes/"
	textboxTileset = "box_01.png"
	textboxContinueCursor = "continue_01.png"
	textboxTilesize = 8
	--This serves as the textbox stack; the textbox renderer can process each textbox in this list 
	--either in the order in which they are listed or by their ID number
	textboxList = {}
	
	--Define default text settings
	defaultLineSpacing = 2 --In pixels
	defaultTextboxWidth = 18 --In tiles
end