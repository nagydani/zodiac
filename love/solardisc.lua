-- Draw solar disc with center at v, radius r
function solardisc(v, r)
	local z = Vec3D(0, 0, 1)
	local m = v:unit()
-- ugly hack TODO: proper polygon
	if m:dot(z) < 0.5 then return end
	local c = dist / v[3]
	love.graphics.circle("fill", c * v[1], c * v[2], c * r)
-- end ugly hack
end
