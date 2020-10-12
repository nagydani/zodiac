function keyboardControl(val, rate, max, att, more, less, dt)
	if love.keyboard.isDown(more) then
		val = val + dt * rate
		if val > max then val = max end
	end

	if love.keyboard.isDown(less) then
		val = val - dt * rate
		if val < -max then val = -max end
	end

	if val > 0 then
		val = val - dt * att
		if val < 0 then val = 0 end
	end

	if val < 0 then
		val = val + dt * att
		if val > 0 then val = 0 end
	end

	return val
end
