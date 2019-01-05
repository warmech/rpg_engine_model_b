require "src/init_engine"
require "src/text_handler"
require "src/system_handler"
require "src/input_handler"

function love.conf(t)
		t.console = true
	end


function love.load()
    initGraphics()
    initUI()
    initTestUI()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end

function love.update(dt)
    --handleText()
end









function love.draw()
    --love.graphics.setCanvas(canvas) --This sets the draw target to the canvas
    --love.graphics.setCanvas() --This sets the target back to the screen
    love.graphics.setColor(1, 1, 1, 1) --Has to be set to white or glitchiness ensues
    love.graphics.draw(canvas, 0, 0, 0, 4, 4)
end





