class_name standing_hurtbox
extends Node2D

signal stading_hurtbox_hit()

func on_stading_hurtbox_hit() -> void:
	stading_hurtbox_hit.emit()
