class_name special_hit
extends Node2D

signal special_hit_signal(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int, knockback_y: int)

func on_hit(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int, knockback_y: int) -> void:
	special_hit_signal.emit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y)
