extends hitbox_manager

func _on__hit_manager_mid_hit_signal(block_stun_frames: Variant, hit_stun_frames: Variant) -> void:
	hit_signal_emit(block_stun_frames,hit_stun_frames,"mid_hit")
	pass # Replace with function body.

func _on__hit_manager_low_hit_signal(block_stun_frames: int, hit_stun_frames: int) -> void:
	hit_signal_emit(block_stun_frames,hit_stun_frames,"low_hit")
	pass # Replace with function body.

func _on_high_hit_manager_high_hit_signal(block_stun_frames: int, hit_stun_frames: int) -> void:
	hit_signal_emit(block_stun_frames,hit_stun_frames,"high_hit")
	pass # Replace with function body.
