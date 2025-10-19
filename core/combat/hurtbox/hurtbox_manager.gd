class_name hurtbox_manager
extends Node2D

signal get_hit(char_state: String)

func get_hit_signal_emit(char_state: String) -> void:
	get_hit.emit(char_state)
