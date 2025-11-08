extends Control




func _on_button_pressed() -> void:
	var packed = load("res://TimerScene.tscn")
	if packed==null:
		push_error("Failed to connect!")
		return
	Global.chai_breaks += 1
	get_tree().change_scene_to_file("res://TimerScene.tscn")
	
		
	# Replace with function body.
