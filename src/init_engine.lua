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
	--Set window size: 320x240 will evenly scale up to 640x480, 960x720, or 1280*960 with no additional work required
	love.window.setMode(1280, 960) 
	--Initialize framebuffer (canvas) and corresponding scale filter
	canvas = love.graphics.newCanvas(320, 240)
	canvas:setFilter("nearest", "nearest")
	--Clear out the background
	love.graphics.setBackgroundColor(0, 0, 0)
	--Scaling factor for all graphics
	gfxScale = 4
	--Reference table for default color schemes
	color = 
	{
		red     = {1, 0, 0},
		green   = {0, 1, 0},
		blue    = {0, 0, 1},
		white   = {1, 1, 1},
		black   = {0, 0, 0},
		yellow  = {1, 1, 0},
		magenta = {1, 0, 1},
		cyan    = {0, 1, 1}		
	}
end

function initUI()
	--Define UI resource path
	UIGraphicsPath = "gfx/UI/"
	--Define font table and set inital game font
	fontPath = "fonts/"
	fontTable = 
	{
		{"text_std_vwf_main.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!,.", 8},
		{"text_inv_vwf.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{}:;,.?/<>~\"\'\\", 8}
	}
	fontMaxHeight = 0 --Default is zero; set by the selectFont function
	selectFont(UIGraphicsPath..fontPath, fontTable[2][1], fontTable[2][2], fontTable[2][3])
	--Initialize the textbox and text object tables
	textboxList = {}
	textObjectList = {}
	--Define text settings
	textAreaDefaultMaxWidth = 128 --Measured in pixels
	textAreaMarginX = 2 --Measured in pixels
	textAreaMarginY = 2 --Measured in pixels
	lineSpacing = 2 --Measured in pixels
	texboxBorderSize = 2 --Measured in pixels
	textboxCornerRadius = 2 --Measured in pixels
	textboxCornerSegments = 1 --Measured in pixels
	textboxBorderColor = color.white
	textboxBodyColor = color.blue
	textColor = color.white
end