extends Node2D

func _ready():
	$GameClock.wait_time = 1.0/globals.tick_speed
	$GameClock.start()

func _process(_delta):
	if Input.is_action_just_pressed("Debug"):
		print(globals.selected_crop)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		globals.sickle_equiped = false
		Input.set_custom_mouse_cursor(null)


func _on_game_clock_timeout():
	globals.game_time += globals.tick_speed
	$GameClock.wait_time = 1.0/globals.tick_speed
	$GameClock.start()
	print(globals.game_time)


func _on_play_stop_button_up():
	if globals.tick_speed != 0:
		globals.tick_speed = 0
	else:
		globals.tick_speed = 1
		$GameClock.wait_time = 1
		$GameClock.start()


func _on_time_x_2_button_up():
	globals.tick_speed = 2


func _on_time_x_4_button_up():
	globals.tick_speed = 4


func _on_time_x_1_button_up():
	globals.tick_speed = 1


func _on_sickle_button_up():
	globals.sickle_equiped = true
	Input.set_custom_mouse_cursor(load("res://Assets/sickle.png"), 0, Vector2(5, 5))
	$"GUI/VBoxContainer/HBoxContainer/Silo".deselect_all()
	globals.selected_crop = []
