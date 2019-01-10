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
		love.graphics.setColor(textboxBorderColor)
		love.graphics.rectangle(textboxDrawMode, window.border.x, window.border.y, window.border.w, window.border.h, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
		--Draw the textbox body
		love.graphics.setColor(textboxBodyColor)
		love.graphics.rectangle(textboxDrawMode, window.body.x, window.body.y, window.body.w, window.body.h, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
		--Set the draw target back to the screen
		--love.graphics.setCanvas()
	end
end

function handleUI()

end