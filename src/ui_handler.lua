function buildWindow(xPos, yPos, width, height)
	local window = 
	{
		visible = false,
		border = 
		{
			x = xPos,
			y = yPos,
			w = width,
			h = height
		},
		body = 
		{
			x = (xPos + 1),
			y = (yPos + 1),
			w = (width - 2),
			h = (height - 2)
		}
	}
	return window
end

function drawWindow(window)
	if (window.visible == true) then
		--Set the draw target to the canvas
		--love.graphics.setCanvas(canvas)
		--Draw the textbox border
		love.graphics.setColor(windowBorderColor)
		love.graphics.rectangle(windowDrawMode, window.border.x, window.border.y, window.border.w, window.border.h, windowCornerRadius, windowCornerRadius, windowCornerSegments)
		--Draw the textbox body
		love.graphics.setColor(windowBodyColor)
		love.graphics.rectangle(windowDrawMode, window.body.x, window.body.y, window.body.w, window.body.h, windowCornerRadius, windowCornerRadius, windowCornerSegments)
		--Set the draw target back to the screen
		--love.graphics.setCanvas()
	end
end

function drawPortrait(character, portraitWindow)
	local portrait = love.graphics.newImage(character.portrait)
	love.graphics.draw(portrait, (portraitWindow.border.x + windowMargin), (portraitWindow.border.y + windowMargin))
end
