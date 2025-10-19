class_name high_hit
extends Node2D

signal high_hit_signal(block_stun_frames: int,hit_stun_frames:int)

func on_hit(block_stun_frames: int, hit_stun_frames: int) -> void:
	high_hit_signal.emit(block_stun_frames,hit_stun_frames)
