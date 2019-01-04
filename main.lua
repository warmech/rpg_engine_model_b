require "src/init_engine"
require "src/text_handler"
require "src/system_handler"

function love.load()
    initGraphics()
    initUI()
    initTestUI()
    
    --[[
    local box1 = buildTextbox(10, 10, 100, 25)
    local box2 = buildTextbox(112, 92, 38, 19)
    local box3 = buildTextbox(250, 200, 50, 20)

    table.insert(textboxList, box1)
    table.insert(textboxList, box2)
    table.insert(textboxList, box3)
    
    
    textObj1 = 
    {
        text = "The warm glow of the CRT dimly illuminates your surroundings...",
        x = 20,
        y = 20
    }
    
    loadTextObject(textObj1)
    ]]
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)
    --handleText()
    drawPrimaryTextbox()
end









function love.draw()
    --love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
    --love.graphics.setCanvas() --This sets the target back to the screen
    love.graphics.setColor(1, 1, 1, 1) --Has to be set to white or glitchiness ensues
    love.graphics.draw(canvas, 0, 0, 0, 4, 4)
end





