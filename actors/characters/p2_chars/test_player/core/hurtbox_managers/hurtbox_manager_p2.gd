extends hurtbox_manager

func _on_air_hurtbox__manager_air_hurtbox_hit() -> void:
	get_hit_signal_emit("on_air_hit")
	#print("on_air_hit")
	
func _on_ground_hurtbox_manager_ground_hurtbox_hit() -> void:
	get_hit_signal_emit("ground_hit")
	#print("ground_hit")

func _on_counter_hurtbox_counter_hurtbox_hit() -> void:
	get_hit_signal_emit("counter_hit")
