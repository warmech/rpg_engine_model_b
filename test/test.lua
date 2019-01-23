text1 = "Hello World! This is a test of the text window parser."
text2 = "This is a test."

text = text1



textTable = {}

tableSize = 1

tableSize = math.ceil(text:len() / 30)

print("String length: "..text:len())
print("Text table size: "..tableSize)


for i = 1, tableSize do
	textTable[i] = {}

	if ((i * 30) > text:len()) then
		jLimit = text:len() % 30
	else
		jLimit = 30
	end
	
	for j = 1, jLimit do
		textTable[i][j] = text:sub(j, j)
	end
end

for i = 1, #textTable do
	for j = 1, #textTable[1] do
		print(textTable[i][j])
	end
end