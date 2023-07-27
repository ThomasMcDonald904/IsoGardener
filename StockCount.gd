extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if globals.selected_crop != [] and globals.selected_crop[1] != 0:
			text = str(globals.selected_crop[1])
			visible = true
	else: 
		visible = false
