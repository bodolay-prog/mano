class_name Player
extends CharacterBody2D

@onready
var movement_animations: AnimatedSprite2D = $move_animations
@onready
var movement_state_machine: Node = $movement_state_machine
@onready
var player_move_component = $player_move_component



func _ready() -> void:
	movement_state_machine.init(self, movement_animations, player_move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	print("input: " + str(player_move_component.inputs()))
	if is_on_floor():
		print("chão")
	print("State: " +str($movement_state_machine.current_state))
	
