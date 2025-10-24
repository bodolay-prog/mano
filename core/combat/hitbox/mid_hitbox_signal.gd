class_name mid_hit
extends Node2D

signal mid_hit_signal(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int)

func on_hit(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int) -> void:
	mid_hit_signal.emit(block_stun_frames, hit_stun_frames, damage, knockback)
