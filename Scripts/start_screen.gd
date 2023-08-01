extends Node2D



func _on_start_button_up():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_how_to_play_button_up():
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")


func _on_exit_button_up():
	get_tree().quit()
