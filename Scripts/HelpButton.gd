extends Button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		get_tree().get_root().get_node("Main/GUI/MarketGUI/HelpIndications").show()
	else:
		get_tree().get_root().get_node("Main/GUI/MarketGUI/HelpIndications").hide()
