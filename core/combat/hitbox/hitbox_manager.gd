class_name hitbox_manager
extends Node2D

var hdk_signal_p1: Signal = SpecialSignal.hadouken_hit_signal_p1
var hdk_signal_p2: Signal = SpecialSignal.hadouken_hit_signal_p2
signal hit(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, knockback_y: int, hit_variant: String)
signal hit_check()

func hit_signal_emit(block_stun_frames: int, hit_stun_frames: int, damage: int, knockback: int, knockback_y: int, hit_variant: String) -> void:
	hit.emit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y, hit_variant)
	hit_check.emit()
