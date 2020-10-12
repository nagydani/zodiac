function waggle(seed)
	local x = (seed[1] + seed[2] + seed[3]) % 0x10000
	seed[1] = seed[2]
	seed[2] = seed[3]
	seed[3] = x
	return seed
end
