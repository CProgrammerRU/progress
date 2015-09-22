function hell.normal_to_hellpos(normal_pos)
	local pos = normal_pos
	pos.x = pos.x
	pos.y = pos.y - 30800
	pos.z = pos.z
	return pos
end

function hell.hell_to_normalpos(hell_pos)
	local pos = hell_pos
	pos.x = pos.x
	pos.y = (pos.y + 30800)
	pos.z = pos.z
	return pos
end

function hell.is_hell_pos(pos)
	return pos.y < hell.border
end

-- When not in hell, object is moved to the hell, else out of it.
function hell.switch_creature_hell(object)
	local pos = object:getpos()
	
	if object:is_player() then

		if not hell.is_hell_pos(pos) then
			object:set_sky("0x803020", "plain")
			pos = hell.normal_to_hellpos(pos)
			object:override_day_night_ratio(0.92)
		else
			object:override_day_night_ratio(nil)
			pos = hell.hell_to_normalpos(pos)
			object:set_sky(nil, "regular")
		end

		object:setpos(pos)
	end
end

minetest.register_chatcommand("hell", {
	params = "",
	description = "go to the hell or get out of it",
	privs = {teleport=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if player then
			hell.switch_creature_hell(player)
		else
			return false, "Player not found"
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	print("aha!")
	if hell.is_hell_pos(player:getpos()) then
		player:set_sky("0x803020", "plain")
		player:override_day_night_ratio(0.92)
		print("set sky and dn-ratio")
	end
end)
