-- Random chest items
-- Zufälliger Kisteninhalt
function rci()
	if nextrandom(0,1) < 0.03 then
		return "farming:bread "..nextrandom(1,3)
	elseif nextrandom(0,1) < 0.05 then
		if nextrandom(0,1) < 0.3 then
			return "farming:seed_cotton "..math.floor(nextrandom(1,4))
		elseif nextrandom(0,1) < 0.5 then
			return "default:sapling "..math.floor(nextrandom(1,4))
		else
			return "farming:seed_wheat "..math.floor(nextrandom(1,4))
		end
	elseif nextrandom(0,1) < 0.005 then
		return "tnt:tnt "..nextrandom(1,3)
	elseif nextrandom(0,1) < 0.003 then
		if nextrandom(0,1) < 0.8 then
			return "default:mese_crystal "..math.floor(nextrandom(1,3))
		else
			return "default:diamond "..math.floor(nextrandom(1,3))
		end
	end
end
-- chests
function place_chest(pos)
	minetest.set_node(pos, {name="default:chest"})
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",
		"invsize[8,9;]"..
		"list[context;main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Chest");
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		--print(dump(meta:to_table()))
		meta:from_table({
			inventory = {
				main = {
					[1] = rci(),[2] = rci(),[3] = rci(),[4] = rci(),[5] = rci(),[6] = rci(),[7] = rci(),[8] = rci(),
					[9] = rci(),[10] = rci(),[11] = rci(),[12] = rci(),[13] = rci(),[14] = rci(),[15] = rci(),[16] = rci(),
					[17] = rci(),[18] = rci(),[19] = rci(),[20] = rci(),[21] = rci(),[22] = rci(),[23] = rci(),[24] = rci(),
					[25] = rci(),[26] = rci(),[27] = rci(),[28] = rci(),[29] = rci(),[30] = rci(),[31] = rci(),[32] = rci()}
				}, -- Why the f does the number of fields vary in the mod??
				fields = {
					formspec = "invsize[8,9;]list[context;main;0,0;8,4;]list[current_player;main;0,5;8,4;]",
					infotext = "Chest"
				}
			}
		)
	end
