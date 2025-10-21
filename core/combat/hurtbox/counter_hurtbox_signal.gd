class_name counter_hurtbox
extends Node2D

signal counter_hurtbox_hit()

func on_counter_hurtbox_hit() -> void:
	counter_hurtbox_hit.emit()
