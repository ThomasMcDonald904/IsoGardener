extends Node2D


func _ready():
	$GameClock.wait_time = 1.0/globals.tick_speed
	$GameClock.start()
	
	$GUI/MainGUI.visible = true
	$GUI/MarketGUI.visible = false
	$World.visible = true

func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		globals.sickle_equiped = false
		Input.set_custom_mouse_cursor(null)

func _unhandled_input(event):
	if event.is_action_pressed("Debug"):
		$World/MisfortuneManager.emit_signal("ColdSnap", 10)

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
	$"GUI/InfoContainer/SiloContainer/Silo".deselect_all()
	globals.selected_crop = []


func _on_market_button_up():
	$GUI/MarketGUI/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/Amount.value = 1
	get_node("World").visible = false
	get_node("GUI/MainGUI").visible = false
	get_node("GUI/MarketGUI").visible = true


func _on_farm_button_up():
	get_node("World").visible = true
	get_node("GUI/MainGUI").visible = true
	get_node("GUI/MarketGUI").visible = false
