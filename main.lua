require "src/init_engine"
require "src/font_handler"
require "src/text_handler"

function love.load()
    initGraphics()

    initText()

    text = 
    {
        metadata = 
        {
            timer = 0,
            iterator = 1,
            speed = .05
        },
        object = "Hello World!"
    }

    love.window.setMode(768, 432)

    love.graphics.setBackgroundColor( 1, 1, 1 )
    
    textbox = buildTextbox(144, 240, 18, 8)
end





function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)
    advanceText(dt)

end

function love.draw()
    --[[
    love.graphics.draw(
        textbox.boxLayer,
        textbox.startX,
        textbox.startY,
        0, 
        3, 
        3
    )]]
    drawText()
end











