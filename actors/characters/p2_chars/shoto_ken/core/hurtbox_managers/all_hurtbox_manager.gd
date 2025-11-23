extends hurtbox_manager


func _on_air_hurtbox_manager_air_hurtbox_hit() -> void:
	get_hit_signal_emit("on_air_hit")
	pass # Replace with function body.


func _on_ground_hurtbox_manager_ground_hurtbox_hit() -> void:
	get_hit_signal_emit("ground_hit")
	pass # Replace with function body.


func _on_counter_hurtbox_manager_counter_hurtbox_hit() -> void:
	get_hit_signal_emit("counter_hit")
	pass # Replace with function body.
