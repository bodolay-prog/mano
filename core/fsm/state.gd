class_name State
extends Node

@export
var animation_name: String
@export
var move_foward_speed: float = 300
@export
var move_back_speed: float = 230

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var animations: AnimatedSprite2D
var input_component
var parent: CharacterBody2D

func enter() -> void:
	animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
		
func input_handler() -> int:
	return input_component.movement_inputs()

func  attack_input_handler() -> String:
	return input_component.attack_inputs()
