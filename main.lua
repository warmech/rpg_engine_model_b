require "src/init_engine"
require "src/text_handler"
require "src/system_handler"
require "src/input_handler"

function love.conf(t)
	t.console = true
end

function drawAlertBox(textbox)
    local borderX	= textbox.border.x
    local borderY	= textbox.border.y
    local borderW	= textbox.border.w
    local borderH	= textbox.border.h
    
    local bodyX		= textbox.body.x
    local bodyY		= textbox.body.y
    local bodyW		= textbox.body.w
    local bodyH		= textbox.body.h

    if textbox.visible == true then
        --Draw the textbox border
        love.graphics.setColor(textboxBorderColor)
        love.graphics.rectangle(textboxDrawMode, borderX, borderY, borderW, borderH, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
        --Draw the textbox body
        love.graphics.setColor(textboxBodyColor)
        love.graphics.rectangle(textboxDrawMode, bodyX, bodyY, bodyW, bodyH, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
    end
end


function buildAlertBox(text)
	local textMargin		= 4
	local textWidth			= love.graphics.getFont():getWidth(text)
	local textHeight		= love.graphics.getFont():getHeight(text)
	local textboxWidth		= textWidth + (textMargin * 2)
	local textboxHeight		= textHeight + (textMargin * 2)
	
	if (textboxWidth % 2 == 1) then
		textboxWidth = textboxWidth + 1
	end
	
	if (textboxHeight % 2 == 1) then
		textboxHeight = textboxHeight + 1
	end
	
	love.graphics.setCanvas(canvas)
	local verticalCenter	= love.graphics.getCanvas():getHeight() / 2
	local horizontalCenter	= love.graphics.getCanvas():getWidth() / 2
	love.graphics.setCanvas()
	
	local xTextbox			= horizontalCenter - (textboxWidth / 2)
	local yTextbox			= verticalCenter - (textboxHeight / 2)
	
	local xText				= xTextbox + textMargin
	local yText				= yTextbox + textMargin
	
	textbox = buildTextbox(xTextbox, yTextbox, textboxWidth, textboxHeight)
	textbox.visible = true
end

function selectFont(fontPath, fontName, fontDefinition, fontHeight)
    local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
    love.graphics.setFont(font)
    fontMaxHeight = fontHeight
    return
end

function love.load()
    initGraphics()
    initUI()
	
	testText = "You are a stupid idiot. I mean, just the worst."
	buildAlertBox(testText)
    
    
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)

end









function love.draw()
	love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
	drawAlertBox(textbox)
	love.graphics.setColor(textColor)
	love.graphics.print(testText, (textbox.border.x + 4), (textbox.border.y + 4))
	love.graphics.setCanvas()

    --love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
    --love.graphics.setCanvas() --This sets the target back to the screen
    
    love.graphics.setColor(1, 1, 1, 1) --Has to be set to white or glitchiness ensues
    love.graphics.draw(canvas, 0, 0, 0, 4, 4)
end





