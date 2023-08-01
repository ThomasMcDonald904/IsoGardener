extends Control

func _on_main_game_ticked():
	$MinuteHand.rotation += 2*PI/60
	$HourHand.rotation += 2*PI/3600
