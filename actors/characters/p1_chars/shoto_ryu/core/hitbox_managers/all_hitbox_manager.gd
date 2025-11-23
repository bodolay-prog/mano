extends hitbox_manager


func _on_high_hit_manager_high_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, 0, "high")
	pass # Replace with function body.


func _on_mid_hit_manager_mid_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, 0, "mid")
	pass # Replace with function body.


func _on_low_hit_manager_low_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, 0, "low")
	pass # Replace with function body.


func _on_low_hit_manager_launcher_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, 0, "launcher")
	pass # Replace with function body.


func _on_low_hit_manager_sweep_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, 0, "sweep")
	pass # Replace with function body.
