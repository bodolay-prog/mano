extends hitbox_manager

signal hit_test(hit_variant: String)

func hit_test_signal_emit( hit_variant: String) -> void:
	hit_test.emit(hit_variant)
	
func _on_high_area_area_entered(area: Area2D) -> void:
	hit_test_signal_emit("high")
	pass # Replace with function body.


func _on_mid_area_area_entered(area: Area2D) -> void:
	hit_test_signal_emit("mid")
	pass # Replace with function body.


func _on_low_area_area_entered(area: Area2D) -> void:
	hit_test_signal_emit("low")
	pass # Replace with function body.
