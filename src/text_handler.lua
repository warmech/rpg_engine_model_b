function buildTextbox(xPos, yPos, width, height)
    local textbox = 
    {
        visible = false,
        blinkerStatus = 0,
        blinkerFrame = 1,
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
        },
        blinker = 
        {
            {
                --Outer border
                x1 = (xPos + width) - 8,
                y1 = (yPos + height) - 4,
                x2 = (xPos + width) - 4,
                y2 = (yPos + height),
                x3 = (xPos + width),
                y3 = (yPos + height) - 4,
                --Inner fill
                x4 = (xPos + width) - 7,
                y4 = (yPos + height) - 4,
                x5 = (xPos + width) - 4,
                y5 = (yPos + height) - 1,
                x6 = (xPos + width) - 1,
                y6 = (yPos + height) - 4
            },
            {
                --Outer border
                x1 = (xPos + width) - 7,
                y1 = (yPos + height) - 4,
                x2 = (xPos + width) - 4,
                y2 = (yPos + height) - 1,
                x3 = (xPos + width) - 1,
                y3 = (yPos + height) - 4,
                --Inner fill
                x4 = (xPos + width) - 6,
                y4 = (yPos + height) - 4,
                x5 = (xPos + width) - 4,
                y5 = (yPos + height) - 2,
                x6 = (xPos + width) - 2,
                y6 = (yPos + height) - 4
            }
        }      
    }
    return textbox
end

function buildTextArea(text, xPos, yPos, width, lines)
    width = width - textAreaMargin
    local maxWidth, textTable = love.graphics.getFont():getWrap(text, width)
    local areaBuffer = {}
    
    for i = 1, lines do
        table.insert(areaBuffer, "")
    end
    
    if (#textTable < lines) then
        lines = #textTable
    end
    
    local textArea = 
    {
        x = xPos + textAreaMargin,
        y = yPos + textAreaMargin,
        textTable = textTable,
        areaBuffer = areaBuffer,
        qtyLines = (#textTable),
        maxLines = lines,
        currentLetter = 1,
        currentLine = 1,
        holdFlag = false
    }
    return textArea
end

function drawTextbox(textboxNumber)
    local borderX = textObjectList[textboxNumber].textbox.border.x
    local borderY = textObjectList[textboxNumber].textbox.border.y
    local borderW = textObjectList[textboxNumber].textbox.border.w
    local borderH = textObjectList[textboxNumber].textbox.border.h
    
    local bodyX = textObjectList[textboxNumber].textbox.body.x
    local bodyY = textObjectList[textboxNumber].textbox.body.y
    local bodyW = textObjectList[textboxNumber].textbox.body.w
    local bodyH = textObjectList[textboxNumber].textbox.body.h

    if textObjectList[textboxNumber].textbox.visible == true then
        --Set the draw target to the canvas
        --love.graphics.setCanvas(canvas)
        --Draw the textbox border
        love.graphics.setColor(textboxBorderColor)
        love.graphics.rectangle(textboxDrawMode, borderX, borderY, borderW, borderH, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
        --Draw the textbox body
        love.graphics.setColor(textboxBodyColor)
        love.graphics.rectangle(textboxDrawMode, bodyX, bodyY, bodyW, bodyH, textboxCornerRadius, textboxCornerRadius, textboxCornerSegments)
        --Set the draw target back to the screen
        --love.graphics.setCanvas()
    end
end

function drawTextArea(textAreaNumber)
    --Set the draw target to the canvas
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(textColor)
    --Print buffer
    for i = 1, textObjectList[textAreaNumber].textArea.maxLines do
        love.graphics.print(textObjectList[textAreaNumber].textArea.areaBuffer[i], (textObjectList[textAreaNumber].textArea.x), (textObjectList[textAreaNumber].textArea.y + ((i - 1) * (fontMaxHeight + lineSpacing))))
    end
    --Set the draw target back to the screen
    love.graphics.setCanvas()
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

function drawContinueBlinker(textboxNumber)
    local blinker = textObjectList[textboxNumber].textbox.blinker
    local frame = textObjectList[textboxNumber].textbox.blinkerFrame
    
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(color.black)
    love.graphics.polygon(textboxDrawMode, blinker[frame].x1, blinker[frame].y1, blinker[frame].x2, blinker[frame].y2, blinker[frame].x3, blinker[frame].y3)
    love.graphics.setColor(color.white)
    love.graphics.polygon(textboxDrawMode, blinker[frame].x4, blinker[frame].y4, blinker[frame].x5, blinker[frame].y5, blinker[frame].x6, blinker[frame].y6)
    love.graphics.setCanvas()
    --Alternate frames
    if (frame == 1) then
        textObjectList[textboxNumber].textbox.blinkerFrame = 2
    else
        textObjectList[textboxNumber].textbox.blinkerFrame = 1
    end
end

function selectFont(fontPath, fontName, fontDefinition, fontHeight)
    local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
    love.graphics.setFont(font)
    fontMaxHeight = fontHeight
    return
end

function advanceText(deltaTime)
    --Update text timer
    textTimePassed = textTimePassed + deltaTime
    --If the timer matches the speed setting, increase the iterator and reset the timer
    if (textTimePassed > textTimePerLetter) then
        local currentLine = nil
        local currentLetter = nil
        local maxLines = nil
        local textTableCurrentLineLength = nil
        local textTableCurrentLetter = nil
        local areaBufferCurrentLine = nil
        local holdFlag = nil
    
        for i = 1, (#textObjectList) do
            holdFlag = textObjectList[i].textArea.holdFlag
            
            
            
            --Add text to buffer
            if(holdFlag == false) then
            
                currentLine = textObjectList[i].textArea.currentLine
                currentLetter = textObjectList[i].textArea.currentLetter
                maxLines = textObjectList[i].textArea.maxLines
                                
                if (currentLine <= maxLines) then
                
                    --print("Actual Current Line: ",textObjectList[i].textArea.currentLine)
                    
                    textTableCurrentLineLength = #textObjectList[i].textArea.textTable[(textObjectList[i].textArea.currentLine)]
                    textTableCurrentLetter = string.sub(textObjectList[i].textArea.textTable[textObjectList[i].textArea.currentLine], textObjectList[i].textArea.currentLetter, textObjectList[i].textArea.currentLetter)
                    areaBufferCurrentLine = textObjectList[i].textArea.areaBuffer[textObjectList[i].textArea.currentLine]
                    
                    --[[
                    print("Current Line: "..currentLine)
                    print("Current Letter: "..currentLetter)
                    print("Max Lines: "..maxLines)
                    print("Text Table - Current Line Length: "..textTableCurrentLineLength)
                    print("Text Table - Current Letter: ",textTableCurrentLetter)
                    print("Area Buffer - Current Line: ",areaBufferCurrentLine)
                    print("Hold Flag: ",holdFlag)
                    ]]

                
                
                    if (currentLetter <= textTableCurrentLineLength) then
                        --areaBufferCurrentLine..textTableCurrentLetter
                        textObjectList[i].textArea.areaBuffer[textObjectList[i].textArea.currentLine] = areaBufferCurrentLine..textTableCurrentLetter
                        --print(areaBufferCurrentLine..textTableCurrentLetter)
                        textObjectList[i].textArea.currentLetter = textObjectList[i].textArea.currentLetter + 1
                    else
                        textObjectList[i].textArea.currentLetter = 1
                        textObjectList[i].textArea.currentLine = textObjectList[i].textArea.currentLine + 1
                        --print("NEW CURRENT LINE: ",textObjectList[i].textArea.currentLine)
                        --print("CURRENT LINE INCREASED")
                    end
                else
                    textObjectList[i].textArea.currentLine = 1
                    textObjectList[i].textArea.holdFlag = true
                end
            end
        end
        textTimePassed = 0
    end
end

function loadTextObject(text, textboxType, xPos, yPos)
    --Generate a unique serial number to bind the text object to its corresonding textbox
    local id = uniqueSerialInt()
    local textboxType = textboxType
    local xPos, yPos = xPos, yPos
    local textboxWidth, textboxHeight = nil, nil
    local maxLines = nil
    
    if (textboxType == "narration") then
        xPos = textboxParams.narration.xPos
        yPos = textboxParams.narration.yPos
        textboxWidth = textboxParams.narration.width
        textboxHeight = textboxParams.narration.height
        maxLines = textboxParams.narration.maxLines
    elseif (textboxType == "notification") then
        xPos = textboxParams.notification.xPos
        yPos = textboxParams.notification.yPos
        textboxWidth = textboxParams.notification.width
        textboxHeight = textboxParams.notification.height
        maxLines = textboxParams.notification.maxLines
    end
    
    local textbox = buildTextbox(xPos, yPos, textboxWidth, textboxHeight)
    local textArea = buildTextArea(text, xPos, yPos, textboxWidth, maxLines)
    
    textbox.visible = true
    
    local textObject = 
    {
        id = id,
        textbox = textbox,
        textArea = textArea
    }
    
    table.insert(textObjectList, textObject)
end

function handleText() --This function is called every update cycle and manages all text-based UI components
    if (#textObjectList > 0) then
        --Capture delta time
        local dt = love.timer.getDelta()
        --Set the draw target to the canvas
        love.graphics.setCanvas(canvas)
        --Cycle through the textbox table and draw each box
        for i = 1, (#textObjectList) do
            drawTextbox(i)
            drawTextArea(i)
            
        end
        --Advance text counters
        advanceText(dt)
        --Set the draw target back to the screen
        love.graphics.setCanvas()
    end
end


