class_name hitbox_manager
extends Node2D

signal hit(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, hit_variant: String)
signal hit_check()

func hit_signal_emit(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, hit_variant: String) -> void:
	hit.emit(block_stun_frames, hit_stun_frames, damage, knockback, hit_variant)
	hit_check.emit()
