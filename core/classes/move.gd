class_name  Movable
extends Node

func wants_jump() -> bool:
	return Input.is_action_just_pressed('jump')
	

func get_movement_direction() -> float:
	return Input.get_axis('move_back','move_foward')
