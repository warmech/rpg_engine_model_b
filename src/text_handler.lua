function buildTextbox(xPos, yPos, width, height, id)
    local textbox = 
    {
        id = id,
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
    return textbox
end

function drawTextbox(textbox)
    if textbox.visible == true then
		love.graphics.setCanvas(canvas)
        --Draw the textbox border
        love.graphics.setColor(textboxBorderColor)
        love.graphics.rectangle(textboxDrawMode, textbox.border.x, textbox.border.y, textbox.border.w, textbox.border.h, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
        --Draw the textbox body
        love.graphics.setColor(textboxBodyColor)
        love.graphics.rectangle(textboxDrawMode, textbox.body.x, textbox.body.y, textbox.body.w, textbox.body.h, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
		love.graphics.setCanvas()
    end
end

function eraseTextbox(id)
    for i = 1, (#textboxList) do
        if (textboxList[i].id == id) then
            textboxList[i].visible = false
        end
    end
end

function deleteTextbox(id)
    for i = 1, (#textboxList) do
        if (textboxList[i].id == id) then
            table.remove(textboxList, textboxList[i])
        end
    end
end

function drawText()
    local textSegment = text.object:sub(1, text.metadata.iterator)
    love.graphics.print(textSegment, 10, 10)
end

function eraseText()

end


function advanceText(deltaTime)
    --Update text timer
    text.metadata.timer = text.metadata.timer + deltaTime
    --If the timer matches the speed setting, increase the iterator and reset the timer
    if text.metadata.timer > text.metadata.speed then
        text.metadata.iterator = text.metadata.iterator + 1
        text.metadata.timer = 0
    end
end

function selectFont(fontPath, fontName, fontDefinition, fontHeight)
    local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
    love.graphics.setFont(font)
    fontMaxHeight = fontHeight
end

function buildTextArea(text, xInit, yInit)
    local maxWidth, textTable = love.graphics.getFont():getWrap(text, textAreaDefaultMaxWidth)
    local newTextObject = {}
    --print(#textTable)
    for i = 1, (#textTable) do
        
        --print(textTable[i])
        --print(obj[1])
        table.insert(newTextObject, {
            text = textTable[i],
            x = (xInit + (textboxCornerRadius * 2)),
            y = (yInit + (textboxCornerRadius * 2)) + ((i - 1) * (fontMaxHeight + lineSpacing))
        })
        --print(newTextObject[i].text)
    end

    return newTextObject
end

function loadTextObject(textObject)
    --Generate a unique serial number to bind the text object to its corresonding textbox
    local id = uniqueSerialInt()
    --Determine how many rows the textbox will require
    local textArea = buildTextArea(textObject.text, textObject.x, textObject.y)
    local textbox = buildTextbox(textObject.x, textObject.y, 150, 50, id)
    
    --print(textArea[1].text)
    
    table.insert(textObjectList, textArea)
    table.insert(textboxList, textbox)
end

function handleText() --This function is called every update cycle and manages all text-based UI components
    --This sets the draw target to the canvas
    love.graphics.setCanvas(canvas)
    --Cycle through the textbox table and draw each box
    for i = 1, (#textboxList) do
        drawTextbox(textboxList[i])
    end


    love.graphics.setColor(textColor)
    for i = 1, (#textObjectList) do
        for j = 1, (#textObjectList[i]) do
            love.graphics.print(textObjectList[i][j].text, textObjectList[i][j].x, textObjectList[i][j].y)
            --print(textObjectList[i][j].text)
        end
        --love.graphics.print(textObjectList[i].text, textObjectList[i].x, textObjectList[i].y)
    end
    --This sets the draw target to the canvas
    love.graphics.setCanvas()
end