class_name P2State
extends Node

@export
var animation_name: String

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var animations: AnimatedSprite2D
var input_component
var parent: P2Character
var animations_player: AnimationPlayer
var node_hitbox_manager : hitbox_manager
var node_hurtbox_manager: hurtbox_manager

func enter() -> void:
	animations_player.play(animation_name)
	
func exit() -> void:
	parent.block_stun_frames = 0
	parent.hit_stun_frames = 0
	parent.hit_variant = ""
	parent.hurt_state = ""

func process_input() -> P2State:
	return null

func process_frame(delta: float) -> P2State:
	return null

func process_physics(delta: float) -> P2State:
	return null
		
func input_handler() -> int:
	return input_component.movement_inputs()

func  attack_input_handler() -> String:
	return input_component.attack_inputs()
