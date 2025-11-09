extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_one_mouse_entered() -> void:
	get_node("Select/playerOne").color = Color.YELLOW_GREEN


func _on_button_one_mouse_exited() -> void:
	get_node("Select/playerOne").color = Color.WHITE


func _on_button_two_mouse_enteredTwo() -> void:
	get_node("Select/playerTwo").color = Color.YELLOW_GREEN


func _on_button_two_mouse_exitedTwo() -> void:
	get_node("Select/playerTwo").color = Color.WHITE


func _on_button_one_pressed() -> void:
	get_tree().change_scene_to_file("")


func _on_button_two_pressed() -> void:
	get_tree().change_scene_to_file("")
