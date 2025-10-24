extends hitbox_manager


func _on_high_hit_manager_high_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, damage, knockback, hit_stun_frames, "high")
	

func _on_mid_hit_manager_mid_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, "mid")


func _on_low_hit_manager_low_hit_signal(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int) -> void:
	hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, "low")
