class_name Ground

extends TileMap

func get_random_selection_with_percentage(input_array: Array, percentage: int) -> Array:
	if percentage >= 100:
		return input_array

	var selected_elements = []
	var nbr_elements_to_select = input_array.size() * percentage / 100
	print("Should remove: " + str(nbr_elements_to_select) + " elements")
	while selected_elements.size() < nbr_elements_to_select:
		var random_index = randi_range(0, input_array.size() - 1)
		var element = input_array[random_index]
		
		if not selected_elements.has(element):
			selected_elements.append(element)
	print("Actually removed: " + str(selected_elements.size()) + " elements")
	return selected_elements


func get_all_first_elements(list: Array) -> Array:
	var holder = []
	for i in list:
		holder.append(i[0])
	return holder

func check_grow():
	# Grid cell structure: crop = [tile_pos, crop_reference, planting_time]
	for crop in globals.grid:
		var tick_age = globals.game_time - crop[2]
		if tick_age >= crop[1].age_1:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(2, crop[1].crop_tileset_row))
		if tick_age >= crop[1].age_2:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(3, crop[1].crop_tileset_row))
		if tick_age >= crop[1].age_3:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(4, crop[1].crop_tileset_row))

func try_harvest(tile_pos: Vector2i):
	var selected_crop_idx = get_all_first_elements(globals.grid).find(tile_pos)
	if selected_crop_idx == -1:
		return;
	var selected_crop_ref = globals.grid[selected_crop_idx]
	if selected_crop_ref[1].isHarvestable(globals.game_time - selected_crop_ref[2]):
		selected_crop_ref[1].onHarvest(self, tile_pos, selected_crop_idx)
		#set_cell(0, tile_pos, get_cell_source_id(0, tile_pos), Vector2i(0, 0))
		#globals.money += selected_crop_ref[1].sell_price
		#globals.grid.remove_at(selected_crop_idx)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and globals.selected_crop != [] and globals.mouse_on_ground and globals.sickle_equiped == false:
		var mouse_pos = to_local(get_viewport().get_mouse_position())
		var tile_pos = local_to_map(mouse_pos)
		if globals.selected_crop[1] != 0 and get_cell_atlas_coords(0, tile_pos) == Vector2i(0, 0):
			globals.grid.append([tile_pos, globals.selected_crop[0], globals.game_time])
			set_cell(0, tile_pos, get_cell_source_id(0, tile_pos), Vector2i(1, 0))
			globals.selected_crop[1] -= 1
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and globals.sickle_equiped:
		var mouse_pos = to_local(get_viewport().get_mouse_position())
		var tile_pos = local_to_map(mouse_pos)
		try_harvest(tile_pos)
	check_grow()

func _on_area_2d_mouse_entered():
	globals.mouse_on_ground = true


func _on_area_2d_mouse_exited():
	globals.mouse_on_ground = false


func _on_misfortune_manager_cold_snap(percent_frozen):
	var frozen_crops = get_random_selection_with_percentage(globals.grid, percent_frozen)
	for frozen_crop in frozen_crops:
		set_cell(0, frozen_crop[0], get_cell_source_id(0, frozen_crop[0]), Vector2i(0, 1))
		globals.diseased_grid.append([frozen_crop[0], frozen_crop[1], globals.game_time])
		globals.grid.erase(frozen_crop)
