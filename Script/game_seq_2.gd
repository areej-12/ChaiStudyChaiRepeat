extends Control




func _ready():
	$Label2.text = "You took " + str(Global.chai_breaks) + " chai breaks ☕\n"+"You took " + str(Global.break_count) + "  breaks;)\n"+"You took " + str(Global.focus_count) + "  Focus Sessions;)"
func _on_button_pressed() -> void:
	var packed = load("res://TimerScene.tscn")
	if packed==null:
		push_error("Failed to connect!")
		return
	get_tree().change_scene_to_file("res://TimerScene.tscn")
		
	# Replace with function body.


func _on_exitbutton_pressed() -> void:
	
	get_tree().quit()
