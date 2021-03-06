--The below function will take as its input a string and a maximum row width; with these parameters, it will build individual lines of text no longer than the provided maximum width and insert them into a table (which is returned) for further manipulation. This function can be executed in a much simpler (and arguably much more efficient) fashion by using the function that immediately proceeds it. I have cobbled together this slapdash affair in an attempt to better undertand how the efficient function produces the output that it does. The below function can certainly be improved, and I look forward to doing so in the future - along with everything else in this stupid game engine.
function wrapText(text, maxLength)

    local charCounter		= 1
    local max_line_length	= maxLength
    local textLength		= text:len()
    local spc				= ""
    local word				= ""
    local line				= ""
    local textLines			= {}
    local currentChar		= text:sub(charCounter, charCounter)

    while (charCounter <= textLength) do
        --Spell word if not presently on a space
        while (currentChar ~= " ") and (charCounter <= textLength) do
            word = word..currentChar
            charCounter = charCounter + 1
            currentChar = text:sub(charCounter, charCounter)
        end
        --Concatenate consecutive spaces
        while (currentChar == " ") and (charCounter <= textLength) do
            spc = spc.." "
            charCounter = charCounter + 1
            currentChar = text:sub(charCounter, charCounter)
        end
        --If current line is longer than the maximum length, write to the table
        if (#line + #spc + #word > max_line_length) then
            table.insert(textLines, line)
            line = word
            word = ""
            spc = ""
        --If parser has reached the end of the given text, write remaining data to the table
        elseif (textLength == charCounter - 1) then
            line = line.." "..word
            table.insert(textLines, line)
        --If the parser has finished reading the first word, initialize the first line
        elseif (line == "") then
            line = word
            word = ""
            spc = ""
        --Concatenate current word to line
        else
            line = line..spc..word
            word = ""
            spc = ""
        end
        --If the parser has reached the end of the given text and the final word was too long for the previous line, write the final line to the table
        if (textLength == charCounter - 1) and (word == "") then
            table.insert(textLines, line)
        end
    end
    
    return textLines
end


function split(str, max_line_length)
    local lines = {}
    local line
    str:gsub('(%s*)(%S+)', 
        function(spc, word) 
            if not line or #line + #spc + #word > max_line_length then
                table.insert(lines, line)
                line = word
            else
                line = line..spc..word
            end
        end
    )
    table.insert(lines, line)
    return lines
end





--[[

function buildTextbox(text, xPos, yPos, width, lines)
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

function drawTextbox(textAreaNumber)
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

]]

function selectFont(fontPath, fontName, fontDefinition, fontHeight)
    local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
    love.graphics.setFont(font)
    fontMaxHeight = fontHeight
    return
end

--[[
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
                    
                    
                    print("Current Line: "..currentLine)
                    print("Current Letter: "..currentLetter)
                    print("Max Lines: "..maxLines)
                    print("Text Table - Current Line Length: "..textTableCurrentLineLength)
                    print("Text Table - Current Letter: ",textTableCurrentLetter)
                    print("Area Buffer - Current Line: ",areaBufferCurrentLine)
                    print("Hold Flag: ",holdFlag)
                    

                
                
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


]]