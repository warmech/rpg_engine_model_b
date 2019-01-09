require "src/init_engine"
require "src/text_handler"
require "src/system_handler"
require "src/input_handler"

function love.load()
    initGraphics()
    initUI()

    text = "Hello World! This is a test... Did it work? Maybe. Who knows? I just want this to work; if it does, yay!"
    textboxType = "narration"
    xPos, yPos = 0, 0
    --loadTextObject(text, textboxType, xPos, yPos)
    blinkTimePassed = 0
    blinkTimeLimit = 0.25
    
    
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)
    --handleText()
    --textboxInputDetect()
    blinkTimePassed = blinkTimePassed + dt
    if (blinkTimePassed >= blinkTimeLimit) then
        drawContinueBlinker(1)
        blinkTimePassed = 0
    end
end










function love.draw()
    --love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
    --love.graphics.setCanvas() --This sets the target back to the screen
    
    love.graphics.setColor(1, 1, 1, 1) --Has to be set to white or glitchiness ensues
    love.graphics.draw(canvas, 0, 0, 0, 4, 4)
end





