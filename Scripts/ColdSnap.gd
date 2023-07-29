extends Node2D



func _on_misfortune_manager_cold_snap(percent_frozen):
	$AnimationPlayer.play("ColdSnap")
