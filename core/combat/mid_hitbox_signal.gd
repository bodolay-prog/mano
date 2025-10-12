class_name mid_hit
extends Node2D

signal mid_hit_signal(block_stun_frames,hit_stun_frames)

func on_hit(block_stun_frames: int, hit_stun_frames: int) -> void:
	mid_hit_signal.emit(block_stun_frames,hit_stun_frames)
