extends TileMap


var grid = []

func get_all_first_elements(list: Array) -> Array:
	var holder = []
	for i in list:
		holder.append(i[0])
	return holder

#func 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func check_grow():
	for crop in grid:
		var tick_age = globals.game_time - crop[2]
		if tick_age >= crop[1].age_1:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(2, 0))
		if tick_age >= crop[1].age_2:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(3, 0))
		if tick_age >= crop[1].age_3:
			set_cell(0, crop[0], get_cell_source_id(0, crop[0]), Vector2i(4, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and globals.selected_crop != [] and globals.mouse_on_ground and globals.sickle_equiped == false:
		var mouse_pos = to_local(get_viewport().get_mouse_position())
		var tile_pos = local_to_map(mouse_pos)
		if globals.selected_crop[1] != 0 and get_cell_atlas_coords(0, tile_pos) == Vector2i(0, 0):
			grid.append([tile_pos, globals.selected_crop[0], globals.game_time])
			set_cell(0, tile_pos, get_cell_source_id(0, tile_pos), Vector2i(1, 0))
			globals.selected_crop[1] -= 1
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and globals.sickle_equiped:
		var mouse_pos = to_local(get_viewport().get_mouse_position())
		var tile_pos = local_to_map(mouse_pos)
		if get_cell_atlas_coords(0, tile_pos) == Vector2i(4, 0):
			set_cell(0, tile_pos, get_cell_source_id(0, tile_pos), Vector2i(0, 0))
			globals.money += grid[get_all_first_elements(grid).find(tile_pos)][1].sell_price
			grid.remove_at(get_all_first_elements(grid).find(tile_pos))
	check_grow()

func _on_area_2d_mouse_entered():
	globals.mouse_on_ground = true


func _on_area_2d_mouse_exited():
	globals.mouse_on_ground = false
