function wrapText(text, maxLength)

	local charCounter		= 1
	local max_line_length	= maxLength
	local textLength		= text:len()
	local spc				= ""
	local word				= ""
	local line				= ""
	local textLines			= {}
	local currentChar		= text:sub(charCounter, charCounter)

	while (charCounter <= textLength) do
		--Spell word if not presently on a space
		while (currentChar ~= " ") and (charCounter <= textLength) do
			word = word..currentChar
			charCounter = charCounter + 1
			currentChar = text:sub(charCounter, charCounter)
		end
		--Concatenate consecutive spaces
		while (currentChar == " ") and (charCounter <= textLength) do
			spc = spc.." "
			charCounter = charCounter + 1
			currentChar = text:sub(charCounter, charCounter)
		end
		--If current line is longer than the maximum length, write to the table
		if (#line + #spc + #word > max_line_length) then
			table.insert(textLines, line)
			line = word
			word = ""
			spc = ""
		--If parser has reached the end of the given text, write remaining data to the table
		elseif (textLength == charCounter - 1) then
			line = line.." "..word
			table.insert(textLines, line)
		--If the parser has finished reading the first word, initialize the first line
		elseif (line == "") then
			line = word
			word = ""
			spc = ""
		--Concatenate current word to line
		else
			line = line..spc..word
			word = ""
			spc = ""
		end
		--If the parser has reached the end of the given text and the final word was too long for the previous line, write the final line to the table
		if (textLength == charCounter - 1) and (word == "") then
			table.insert(textLines, line)
		end
	end
	
	return textLines
end

text1 = "Hello World! This is a test of the text window parser."
text2 = "Whatever you do, make sure there is a line breaking size of word at column 30! Also, make this text go long..."
text3 = "This is a test."
text4 = "AAAAAAAAAAAAAAAAAAAA BBBBBBBB CCCCCCCCCCCCC DDDD EEEEEEEEEEEEEEEEE FFFFFFFFFFFFFFFFFFFF"


textTable = wrapText(text2, 30)

for i = 1, #textTable do
	line = "|"
	for j = 1, #textTable[i] do
		line = line..string.sub(textTable[i], j, j).."|"
	end
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
]]





