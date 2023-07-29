extends Node2D

signal ColdSnap(percent_frozen: int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if globals.game_time % 150 == 0 and globals.game_time != 0:
		ColdSnap.emit(10)
