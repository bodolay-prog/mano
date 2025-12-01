class_name low_hit
extends Node2D

signal low_hit_signal(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int)
signal launcher_hit_signal(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int)
signal sweep_hit_signal(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int)

func on_hit(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int) -> void:
	low_hit_signal.emit(block_stun_frames, hit_stun_frames, damage, knockback)
	
func on_launcher(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int) -> void:
	launcher_hit_signal.emit(block_stun_frames, hit_stun_frames, damage, knockback)

func on_sweep(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int) -> void:
	sweep_hit_signal.emit(block_stun_frames, hit_stun_frames, damage, knockback)
