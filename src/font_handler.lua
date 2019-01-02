fontPath = "/gfx/font/"

fontTable = 
{
	{"text_std_vwf_main.png"," ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!,."}
}

function selectFont(fontPath, fontName, fontDefinition)
	local font = love.graphics.newImageFont(fontPath..fontName,fontDefinition)
	love.graphics.setFont(font)
end