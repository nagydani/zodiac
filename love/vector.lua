vec3D = {
	__tostring = function(a)
		return a[1]..","..a[2]..","..a[3]
	end,

	__add = function(a, b)
		return Vec3D(a[1] + b[1], a[2] + b[2], a[3] + b[3])
	end,

	__mul = function(a, b)
		return Vec3D(
			a[2] * b[3] - a[3] * b[2],
			a[3] * b[1] - a[1] * b[3],
			a[1] * b[2] - a[2] * b[1])
	end,

	dot = function(a, b)
		return a[1] * b[1] + a[2] * b[2] + a[3] * b[3]
	end,

	scale = function(a, b)
		return Vec3D(a[1] * b, a[2] * b, a[3] * b)
	end

}

vec3D.__index = vec3D

function Vec3D(x, y, z)
	local v = {x, y, z}
	setmetatable(v, vec3D)
	return	v
end

ZeroVec3D = Vec3D(0, 0, 0)

rot3D = {
	__tostring = function(a)
		return a[1]..","..a[2]
	end,

	__mul = function(a, b)
		return Rot3D(
			a[1] * b[1] - a[2]:dot(b[2]),
			a[2] * b[2] + a[2]:scale(b[1]) + b[2]:scale(a[1]))
	end,

	mat = function(a)
		local r = a[1]
		local i = a[2][1]
		local j = a[2][2]
		local k = a[2][3]
		local ii = i * i
		local jj = j * j
		local kk = k * k
		local ir = i * r
		local jr = j * r
		local kr = k * r
		local ij = i * j
		local jk = j * k
		local ik = i * k
		return {
			Vec3D(1 - 2*(jj + kk), 2*(ij - kr), 2*(ik + jr)),
			Vec3D(2*(ij + kr), 1 - 2*(ii + kk), 2*(jk - ir)),
			Vec3D(2*(ik - jr), 2*(jk + ir), 1 - 2*(ii + jj))
		}
	end
}

rot3D.__index = rot3D

function Rot3D(r, i)
	local e = r * r + i:dot(i) - 1
	local s = 1 - 0.5 * e
	local x = {r * s, i:scale(s)}
	setmetatable(x, rot3D)
	return x
end

function PitchYawRoll(p, y, r)
	local v = Vec3D(p, y, r)
	return Rot3D(1 - 0.5 * v:dot(v), v)
end

ZeroRot3D = Rot3D(1, ZeroVec3D)

