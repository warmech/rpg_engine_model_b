text1 = "Hello World! This is a test of the text window parser."
text2 = "Whatever you do, make sure there is a line breaking size of word at column 30! Also, make this text go long..."
text3 = "This is a test."
text4 = "AAAAAAAAAAAAAAAAAAAA BBBBBBBB CCCCCCCCCCCCC DDDD EEEEEEEEEEEEEEEEE FFFFFFFFFFFFFFFFFFFF"

--AAAAAAAAAAAAAAAAAAAA BBBBBBBB CCCCCCCCCCCCC DDDD EEEEEEEEEEEEEEEEE FFFFFFFFFFFFFFFFFFFF

text = text4


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

local main_string = text
for _, line in ipairs(split(main_string, 30)) do
	print(line)
end

--[[
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

local main_string = text
for _, line in ipairs(split(main_string, 30)) do
	print(line)
end
]]

--[[
textTable	= {}
charCounter	= 1
wordSize	= 1
lineLength	= 30
lineLevel	= 1
textLength	= text:len()
textBuffer	= ""
endFlag		= false
segLength	= 30

while (charCounter <= textLength) do
	textTable[lineLevel] = {}
	
	for i = 1, textLength do
		--If a space is encountered...
		if (text:sub(charCounter, charCounter) == " ") then
			--...count the number of characters until the next space
			while ((text:sub(charCounter + wordSize, charCounter + wordSize) ~= " ") and ((charCounter + wordSize) <= textLength) and (endFlag == false)) do
				if ((charCounter + wordSize) <= textLength) then
					wordSize = wordSize + 1
				else
					endFlag = true
				end
			end			
			--If the detected word is shorter than the remaining whitespace, proceed with adding the word			
			--if ((wordSize - 1) <= ((lineLength * lineLevel) - charCounter)) then
			if ((wordSize) <= (segLength - charCounter)) then
				--print(text:sub(charCounter, charCounter))
				--table.insert(textTable[lineLevel], text:sub(charCounter, charCounter))
				textBuffer = textBuffer..text:sub(charCounter, charCounter)
			else
				lineLevel = lineLevel + 1
				textTable[lineLevel] = {}
				textBuffer = ""
				--Recalculate the text segment length
				if (segLength * lineLevel > textLength) then
					segLength = textLength
				else
					segLength = (lineLength * lineLevel)
				end
			end
			wordSize = 1
		else
			--print(text:sub(charCounter, charCounter))
			--table.insert(textTable[lineLevel], text:sub(charCounter, charCounter))
			textBuffer = textBuffer..text:sub(charCounter, charCounter)
			print(textBuffer)
		end	
		charCounter = charCounter + 1
	end
end

]]

--[[
lineLength	= 30
textLength	= text:len()
textTable	= {}
tableSize	= 1
tableSize	= math.ceil(text:len() / lineLength)
charCounter	= 1
wordSize	= 1




while (charCounter <= textLength) do
	for i = 1, tableSize do
		--Create new text row
		textTable[i] = {}
		--Determine correct length of row
		if ((i * lineLength) > textLength) then
			charLimit = textLength % lineLength
		else
			charLimit = lineLength
		end
		--Read first/next character in string
		for j = 1, charLimit do
			--If a space is encountered...
			if (text:sub(charCounter, charCounter) == " ") then
				--...count the number of characters until the next space
				while (text:sub(charCounter + wordSize, charCounter + wordSize) ~= " " and (charCounter + wordSize) <= textLength) do
					--print("CHAR: "..text:sub(charCounter + wordSize, charCounter + wordSize))
					--print("LOC: "..(charCounter + wordSize))
					wordSize = wordSize + 1
				end
				--print("WORD SIZE: "..wordSize)
				--print("REM SPACE: "..(lineLength - j))
				--If the detected word is shorter than the remaining whitespace, proceed with adding the word
				if ((wordSize - 1) <= (lineLength - j)) then
					textTable[i][j] = text:sub(charCounter, charCounter)
				else
					
				end
				wordSize = 1
			else
				textTable[i][j] = text:sub(charCounter, charCounter)
			end
			charCounter = charCounter + 1
		end
	end
end

for i = 1, #textTable do
	print("Row length: "..#textTable[i])
	textLine = ""
	for j = 1, #textTable[i] do
		textLine = textLine..textTable[i][j]
	end
	print(textLine)
end
]]