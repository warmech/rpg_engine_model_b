function buildTextbox(xPos, yPos, width, height, objectID)
    local textbox = 
    {
        id = objectID,
        visible = true,
        border = 
        {
            drawMode = "fill",
            x = xPos,
            y = yPos,
            w = width,
            h = height,
            r = textboxCornerRadius,
            s = textboxCornerSegments,
            c = textboxBorderColor
        },
        body = 
        {
            drawMode = "fill",
            x = (xPos + 1),
            y = (yPos + 1),
            w = (width - 2),
            h = (height - 2),
            r = textboxCornerRadius,
            s = textboxCornerSegments,
            c = textboxBodyColor
        }
    }
    return textbox
end

function buildStaticTextbox()
     
end

function drawPrimaryTextbox()
    if primaryTextbox.visible == true then
        love.graphics.setCanvas(canvas)
        --Draw the textbox border textboxParams.narration.
        love.graphics.setColor(textboxParams.narration.borderC)
        love.graphics.rectangle(textboxParams.narration.drawMode, textboxParams.narration.borderX, textboxParams.narration.borderY, textboxParams.narration.borderW, textboxParams.narration.borderH, textboxParams.narration.borderR, textboxParams.narration.borderR, textboxParams.narration.borderS)
        love.graphics.setColor(textboxParams.narration.bodyC)
        love.graphics.rectangle(textboxParams.narration.drawMode, textboxParams.narration.bodyX, textboxParams.narration.bodyY, textboxParams.narration.bodyW, textboxParams.narration.bodyH, textboxParams.narration.bodyR, textboxParams.narration.bodyR, textboxParams.narration.bodyS)
        love.graphics.setCanvas()
    end
end



function drawTextbox(textbox)
    if textbox.visible == true then
        --Draw the textbox border
        love.graphics.setColor(textbox.border.c)
        love.graphics.rectangle(textbox.border.drawMode, textbox.border.x, textbox.border.y, textbox.border.w, textbox.border.h, textbox.border.r, textbox.border.r, textbox.border.s)
        --Draw the textbox body
        love.graphics.setColor(textbox.body.c)
        love.graphics.rectangle(textbox.body.drawMode, textbox.body.x, textbox.body.y, textbox.body.w, textbox.body.h, textbox.body.r, textbox.body.r, textbox.body.s)
    end
end

function eraseTextbox(id)
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