extends Node

signal p2_hurt()

func p2_hurt_emit() -> void:
	p2_hurt.emit()
	
