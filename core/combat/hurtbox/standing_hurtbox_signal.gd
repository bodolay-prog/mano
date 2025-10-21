class_name ground_hurtbox
extends Node2D

signal ground_hurtbox_hit()

func on_ground_hurtbox_hit() -> void:
	ground_hurtbox_hit.emit()
