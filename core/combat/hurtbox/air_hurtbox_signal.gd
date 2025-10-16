class_name air_hurtbox
extends Node

signal air_hurtbox_hit()

func on_air_hurtbox_hit() -> void:
	air_hurtbox_hit.emit()
