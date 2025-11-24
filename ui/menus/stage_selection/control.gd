extends Control
func _process(delta: float) -> void:
	pass
	



func _on_button_mouse_entered() -> void:
	$Preview.icon=ResourceLoader.load("res://AIDrawing_251109_da726062-310e-497c-8b2e-4667b03abf9e_0_MiriCanvas.png")



func _on_button_2_mouse_entered() -> void:
	$Preview.icon=ResourceLoader.load("res://AIDrawing_251109_371759a3-7bbd-4267-ac65-d4e5dc47bbd2_0_MiriCanvas.png")
