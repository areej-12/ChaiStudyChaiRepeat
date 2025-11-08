extends Control




func _on_button_pressed() -> void:
	var packed = load("res://GameSeq1.tscn")
	if packed==null:
		push_error("Failed to connect!")
		return
	get_tree().change_scene_to_file("res://GameSeq1.tscn")
		
	# Replace with function body.
