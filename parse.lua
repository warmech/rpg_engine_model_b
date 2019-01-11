







text = "Hello World!"


function processText(text)

	local charTable = {}
	
	text:gsub(".", function(c) table.insert(charTable, c) end)
	
	for i = 1, #charTable do
		print(charTable[i])
	end

end

processText(text)


--[[
Lua Regex Character Classes

.	all characters
%a	letters
%c	control characters
%d	digits
%l	lower case letters
%p	punctuation characters
%s	space characters
%u	upper case letters
%w	alphanumeric characters
%x	hexadecimal digits
%z	the character with representation 0

]]


--[[
local chars = {} --empty table. will be filled with individual charachters from (text)
text:gsub(".",function(c) table.insert(chars,c) end) --fill table as described above
textimer = timer:every(textspeed,function() --the timer. calls this function every textspeed of a second
	
	if chars[1] == "<" then --if the beginning of a tag
		textcolor = "" -- the color is blank
		table.remove(chars,1) --remove tag beginning 
		while chars[1] ~= ">" do --while the tag is still going on
			textcolor = textcolor .. chars[1] --the current character is added to the textcolor
			table.remove(chars,1) --and then removed from the table.
		end
		table.remove(chars,1)--this only executes once the tag is finished, because of the while function
		textcolor = _G[textcolor] --this turns the string into a variable to work with setColor
	end






love.graphics.setColor(0.25,0.25,0.67) -- set color to black
love.graphics.rectangle("fill",box.x-13,box.y,box.width,Font:getHeight()*box.lines,15,15,3) -- this box is drawn first, so everything else is drawn over it. It makes the background of the box non transparent
love.graphics.setColor(textcolor) --set color to white
love.graphics.print(currenttext,box.x,box.y)--draw the actual text
love.graphics.setColor(White)
love.graphics.setLineWidth(1.5) --thicker line
love.graphics.rectangle("line",box.x-13,box.y,box.width,Font:getHeight()*box.lines,15,15,3) --draw the box
love.graphics.setLineWidth(1) --regular line

]]