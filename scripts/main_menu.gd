extends PopupDialog


func _on_about_to_show():
	var time = get_node("/root/main_scene/ui/VBoxContainer/time_label").time
	print(time)
	if get_tree().paused == true and time > 0.0:
		get_node("VBoxContainer/continue").show()
	else:
		get_node("VBoxContainer/continue").hide()
