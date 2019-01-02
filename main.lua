require "src/init_engine"
require "src/text_handler"

function love.load()
    initGraphics()
    initUI()

    text = 
    {
        metadata = 
        {
            timer = 0,
            iterator = 1,
            speed = .05
        },
        object = "Hello World! This is a test of the text wrapper."
    }

    love.window.setMode(800, 600)

    love.graphics.setBackgroundColor( 1, 1, 1 )
    
    --textbox = buildTextbox(100, 100, 18, 8)
    --buildTextArea(text.object, 120, 48)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)
    --advanceText(dt)
    handleText()
end

function love.draw()
--[[
    love.graphics.draw(
        textbox.boxLayer,
        textbox.startX,
        textbox.startY,
        0
    )
    --drawText()
    ]]
end











