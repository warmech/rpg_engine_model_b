require "src/init_engine"
require "src/text_handler"
require "src/system_handler"
require "src/input_handler"
require "src/ui_handler"

function love.conf(t)
	t.console = true
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
	
	textbox = buildWindow(xTextbox, yTextbox, textboxWidth, textboxHeight)
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
	
	textbox = {}
	testText = "You are a stupid idiot. I mean, just the worst."
	buildAlertBox(testText)
    
    textbox_1 = buildWindow(window.textbox.xPos, window.textbox.yPos, window.textbox.width, window.textbox.height)
	portrait_1 = buildWindow(window.portrait.xPos, window.portrait.yPos, window.portrait.width, window.portrait.height)
	
	textbox_1.visible = true
	portrait_1.visible = true
	
	character_1 = 
	{
		portrait = UIGraphicsPath..portraitPath.."locke.png"
	}
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
	drawWindow(textbox)
	--love.graphics.setColor(textColor)
	love.graphics.setColor(color.yellow)
	love.graphics.print(testText, (textbox.border.x + 4), (textbox.border.y + 4))
	
	drawWindow(textbox_1)
	drawWindow(portrait_1)
	
	love.graphics.setColor(color.white)
	drawPortrait(character_1, portrait_1)
	
	love.graphics.setCanvas()

    --love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
    --love.graphics.setCanvas() --This sets the target back to the screen
    
    love.graphics.setColor(1, 1, 1, 1) --Has to be set to white or glitchiness ensues
    love.graphics.draw(canvas, 0, 0, 0, 4, 4)
end





