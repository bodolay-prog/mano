extends hurtbox_manager

func _on_stading_hurtbox_manager_stading_hurtbox_hit() -> void:
	get_hit_signal_emit("ground_hit")
	#print("standing_hit")
	pass # Replace with function body.


func _on_air_hurtbox_manager_air_hurtbox_hit() -> void:
	get_hit_signal_emit("on_air_hit")
	#print("on_air_hit")
	pass # Replace with function body.
