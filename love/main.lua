function love.load()
	dofile("waggle.lua")
	dofile("vector.lua")
	dofile("starbox.lua")
	dofile("control.lua")

	attitude = ZeroRot3D
	pitch = 0
	pitchRate = 1
	pitchAtt = 0.3
	pitchMax = 0.4
	roll = 0
	rollRate = 1
	rollAtt = 0.3
	rollMax = 0.4
end

function love.draw()
	dist = 0.7 * love.graphics.getWidth()
	love.graphics.setBackgroundColor(0, 0, 0)
	love.graphics.setColor(1, 1, 1)
	local tr = love.math.newTransform()
	tr:translate(0.5 * love.graphics.getWidth(), 0.5 * love.graphics.getHeight())
	love.graphics.replaceTransform(tr)
	
	local attmat = attitude:mat()
	starbox(attmat)
end

function love.update(dt)
	roll = keyboardControl(roll, rollRate, rollMax, rollAtt, "o", "p", dt)
	pitch = keyboardControl(pitch, pitchRate, pitchMax, pitchAtt, "q", "a", dt)

	attitude = PitchYawRoll(pitch * dt, 0, roll * dt) * attitude
end
