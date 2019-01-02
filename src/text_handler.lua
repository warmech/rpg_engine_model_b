function buildTextbox(startX, startY, width, height)

    local function buildTileset(fileName, tilesize)
        --Create quad table and import the appropriate tileset file
        local tileset = {}
        local tilesetFile = love.graphics.newImage(fileName)
        --This filter is configurable based upon game settings, but should probably be locked to nearest/nearest
        local filter_min = "nearest"
        local filter_mag = "nearest"
        tilesetFile:setFilter(filter_min, filter_mag)
        local tilesetQuadIndex = 1
        --Iterate down the tileset's rows by multiples of tilesize pixels (16 is default)
        for y = 1, (tilesetFile:getHeight() / tilesize) do
            --Iterate across the tileset's columns by multiples of tilesize pixels (16 is default)
            for x = 1, (tilesetFile:getWidth() / tilesize) do
                --Read the (tilesize * tilesize) pixel group at ((x - 1) * tilesize), ((y - 1) * tilesize) into a new quad
                tileset[tilesetQuadIndex] = love.graphics.newQuad(((x - 1) * tilesize), ((y - 1) * tilesize), tilesize, tilesize, tilesetFile:getWidth(), tilesetFile:getHeight())
                tilesetQuadIndex = tilesetQuadIndex + 1
            end
        end
        return tileset, tilesetFile
    end

    local function buildSpriteBatch(tileset, tilesetFile, textboxTable, tilesize)
        --Create a new sprite batch the size fo the textbox with the tileset file
        local tilesetSpriteBatch = love.graphics.newSpriteBatch(tilesetFile, width * height)
        --Clear out the textbox canvas
        tilesetSpriteBatch:clear()
        --Iterate down the rows of the textbox
        for y = 0, (height - 1) do
            --Iterate across the columns of the textbox
            for x = 0, (width - 1) do
                --Write the appropriate tile to the current cell in the sprite batch
                tilesetSpriteBatch:add(tileset[(textboxTable[y + 1][x + 1])], x * tilesize, y * tilesize)
            end
        end
        --Send data to GPU
        tilesetSpriteBatch:flush()
        return tilesetSpriteBatch
    end

    local function buildTextboxTable(width, height)
        --Build textbox table and populate borders and body with corresponding tile IDs
        local textboxTable = {}
        for y = 1, height do
            textboxTable[y] = {}
            for x = 1, width do
                if (y == 1 and x == 1) then
                    --Upper-Left Corner
                    textboxTable[y][x] = 1
                elseif (y == 1 and x > 1 and x < width) then
                    --Upper Border
                    textboxTable[y][x] = 6
                elseif (y == 1 and x == width) then
                    --Upper-Right Corner
                    textboxTable[y][x] = 2
                elseif (y > 1 and y < height and x == 1) then
                    --Left Border
                    textboxTable[y][x] = 7
                elseif (y > 1 and y < height and x > 1 and x < width) then
                    --Whitespace
                    textboxTable[y][x] = 9
                elseif (y > 1 and y < height and x == width) then
                    --Right Border
                    textboxTable[y][x] = 5
                elseif (y == height and x == 1) then
                    --Lower-Left Corner
                    textboxTable[y][x] = 3
                elseif (y == height and x > 1 and x < width) then
                    --Lower Border
                    textboxTable[y][x] = 8
                elseif (y == height and x == width) then
                    --Lower-Right Corner
                    textboxTable[y][x] = 4
                end
            end
        end

        return textboxTable
    end

    --Declare file name for tileset image and declare the tile size
    local tilesetFileName = UIGraphicsPath..textboxGraphicsPath..textboxTileset
    local tilesize = textboxTilesize
    
    local metadata = 
    {
        id = (#textboxList + 1),
        visible = false,
        textboxX  = startX,
        textboxY  = startY,
        textboxWidth = width,   --width of the textbox in tiles
        textboxHeight = height,   --height of the textbox in tiles
        continueX = (textboxX + ((textboxWidth - 2) * tilesize)), --continue cursor will always be drawn at the second tile from the right on the bottom border of the text box
        continueY = (textboxY + (textboxHeight * tilesize)),
        textAreaMargin = tilesize + math.ceil(tilesize / 2), --text area bound to a (tilesize + (tilesize * 0.5)) pixel margin inside the textbox
        textAreaX = textboxX + textAreaMargin,
        textAreaY = textboxY + textAreaMargin,
        textAreaWidth = ((textboxX + (width * tilesize) - textAreaMargin) - textAreaX),  --width of the text area in pixels
        textAreaHeight = ((textboxY + (height + tilesize) - textAreaMargin) - textAreaY) --height of the text area in pixels
    }
    

    --Build tileset, sprite batch, and textbox object
    local tileset, tilesetFile = buildTileset(tilesetFileName, tilesize)
    local textboxTable = buildTextboxTable(width, height)
    local boxLayer = buildSpriteBatch(tileset, tilesetFile, textboxTable, tilesize)
    local textbox = {tileset = tileset, boxLayer = boxLayer, metadata = metadata}

    return textbox
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

function buildTextArea(text, width, height)
    maxWidth, textTable = love.graphics.getFont():getWrap(text, width)
    
end

function drawText()
    --love.graphics.scale(3)
    local textSegment = text.object:sub(1, text.metadata.iterator)
    love.graphics.print(textSegment, 10, 10)
end

function loadTextObject(text, xPos, yPos, width, height)
    if width == nil then
        width = defaultTextboxWidth
        local x = buildTextArea(text, textbox.metadata.textAreaWidth, textbox.metadata.textAreaHeight)
    end
    
    local textbox = buildTextbox(xPos, yPos, width, height)
    local x = buildTextArea(text, textbox.metadata.textAreaWidth, textbox.metadata.textAreaHeight)

    
end











function selectFont(fontPath, fontName, fontDefinition)
    local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
    love.graphics.setFont(font)
end

function handleText()
    --This function is called every update cycle and manages all text-based UI components
end