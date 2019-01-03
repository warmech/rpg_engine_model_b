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

    love.graphics.setBackgroundColor( 0, 0, 0 )
    
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
    --handleText()
end

function love.draw()
	love.graphics.setColor(0, 0, 1)
	love.graphics.rectangle( "fill", 20, 20, 200, 50, 2, 2, 1)
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle( "line", 20, 20, 200, 50, 1, 1, 1)

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







