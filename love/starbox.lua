-- Draw starry sky corresponding to attitude rotation matrix m
function starbox(m)
	local seed = {0x5A4A, 0x0248, 0xB753}

	local function rl(a)
		local h = bit.band(a, 0x8080)
		local l = bit.band(a, 0x7F7F)
		return bit.rshift(h, 7) + bit.lshift(l, 1)
	end

	local function next()
		for i = 1, 3 do seed[i] = rl(seed[i]) end
	end

	for i = 1, 3 do
		local dom = 0x80

		if m[3][4 - i] < 0 then
			next()
			dom = -0x80
		end

		local s = {seed[1], seed[2], seed[3]}

		for j = 0, 0xFF do
			local x, y = bit.rshift(s[1], 8) - 0x80, bit.rshift(s[2], 8) - 0x80
			local v
			if i == 1 then
				v = Vec3D(y, x, dom)
			elseif i == 2 then
				v = Vec3D(x, dom, y)
			else
				v = Vec3D(dom, y, x)
			end
			local z = v:dot(m[3])

			if z > 20 then
				local c = dist / z
				love.graphics.points(
					v:dot(m[1]) * c,
					v:dot(m[2]) * c)
			end
			for k = 1, 4 do waggle(s) end
		end
		if dom == 0x80 then next() end
		next()
	end
end
