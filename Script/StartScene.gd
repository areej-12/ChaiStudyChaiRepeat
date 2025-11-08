
extends Control

func _on_lets_start_pressed() -> void:
	var packed = load("res://MainTimerScene.tscn")
	if packed==null:
		push_error("Failed to connect!")
		return
	get_tree().change_scene_to_file("res://MainTimerScene.tscn")
		
