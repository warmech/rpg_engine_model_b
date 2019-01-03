function uniqueSerialInt()
	return math.floor(os.time() + (os.clock() * 10^6))
end