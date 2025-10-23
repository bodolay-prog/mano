extends Node

signal p1_hurt()

func p1_hurt_emit() -> void:
	p1_hurt.emit()
