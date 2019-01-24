text1 = "Hello World! This is a test of the text window parser."
text2 = "Whatever you do, make sure there is a line breaking size of word at column 30! Also, make this text go long..."
text3 = "This is a test."
text4 = "AAAAAAAAAAAAAAAAAAAA BBBBBBBB CCCCCCCCCCCCC DDDD EEEEEEEEEEEEEEEEE FFFFFFFFFFFFFFFFFFFF"

text = text3



charCounter		= 1
wordSize		= 1
max_line_length	= 30
textLength		= text:len()
textBuffer		= ""
spc				= ""
word			= ""
line			= ""
textLines		= {}

--print(textLength)

while (charCounter <= textLength) do
	for i = 1, textLength do
		--Define current character
		currentChar = text:sub(charCounter, charCounter)
		--If current character is not a space, build the current word
		if (currentChar ~= " ") then
			word = word..currentChar
			wordSize = wordSize + 1
		--If a space is encountered
		elseif (currentChar == " ") then
			print(wordSize - 1)
			spc = spc.." "
			wordSize = 1
			--Define next character
			nextChar = text:sub(charCounter + wordSize, charCounter + wordSize)
			--count the number of characters until the next space
			if (nextChar ~= " ") then
				if ((charCounter + wordSize) <= textLength) then
					wordSize = wordSize + 1
				end
				spc = ""
			else
				
			end
		else
			print()
		end	
		charCounter = charCounter + 1
	end
end

--This is a test.

--[[
if (not line) or (#line + #spc + #word > max_line_length) then
	table.insert(textLines, line)
	line = word
else
	line = line..spc..word
	print(line)
end
]]

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


function wordWrap(string, max_line_length)

	local lines = {}
	local line
	
	
		if (not line) or (#line + #spc + #word) > max_line_length then
			table.insert(lines, line)
			line = word
		else
			line = line..spc..word
		end





end

for _, line in ipairs(wordWrap(text, 30)) do
	print(line)
end


]]

--[[

while (charCounter <= textLength) do
	for i = 1, textLength do
		--Define current character
		currentChar = text:sub(charCounter, charCounter)
		if (currentChar ~= " ") then
			word = word..currentChar
			wordSize = wordSize + 1
		else
		
		--If a space is encountered...
		if (currentChar == " ") then
			spc = spc.." "
			wordSize = 1
			--Define next character
			nextChar = text:sub(charCounter + wordSize, charCounter + wordSize)
			--count the number of characters until the next space
			if (nextChar == " ") then
				--spc = spc.." "
			else
				while ((charCounter + wordSize) <= textLength) do
					if ((charCounter + wordSize) <= textLength) then
						wordSize = wordSize + 1
					end
				end
				print("|"..spc.."|")
				spc = ""
				textBuffer = textBuffer..spc
				wordSize = 1
			end
			--print("|"..spc.."|")
		else
			word = word..currentChar
			wordSize = wordSize + 1
			print(word)
		end	
		--print(wordSize)
		charCounter = charCounter + 1
	end
end

]]
