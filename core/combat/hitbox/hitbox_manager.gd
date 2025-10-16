class_name hitbox_manager
extends Node2D

signal hit(block_stun_frames: int, hit_stun_frames: int, hit_variant: String)

func hit_signal_emit(block_stun_frames: int, hit_stun_frames: int, hit_variant: String) -> void:
	hit.emit(block_stun_frames,hit_stun_frames,hit_variant)
