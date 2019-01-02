function initGraphics()
	--Set scaling filter to "nearest"
	love.graphics.setDefaultFilter("nearest","nearest")
end

function initText()
	selectFont(fontPath, fontTable[1][1], fontTable[1][2])
end
