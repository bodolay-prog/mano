extends Control


func _on__x_1_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")


func _on__x_ia_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
