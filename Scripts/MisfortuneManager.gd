extends Node2D

signal ColdSnap(percent_frozen: int)

@export var cold_snap_heal_time = 10

var cold_snap_time = 0
@onready var ground = get_node("../Ground")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if globals.game_time - cold_snap_time == 150 and globals.game_time != 0:
		cold_snap_time = globals.game_time
		ColdSnap.emit(10)
	if globals.game_time == cold_snap_heal_time + cold_snap_time:
		for diseased_crop in globals.diseased_grid:
			if ground.get_cell_atlas_coords(0, diseased_crop[0]) == Vector2i(0, 1):
				ground.set_cell(0, diseased_crop[0], ground.get_cell_source_id(0, diseased_crop[0]), Vector2i(0, 0))
				globals.diseased_grid.erase(diseased_crop)
