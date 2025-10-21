class_name crouch_hurtbox
extends Node2D

signal crouch_hurtbox_hit()

func on_crouch_hurtbox_hit() -> void:
	crouch_hurtbox_hit.emit()
