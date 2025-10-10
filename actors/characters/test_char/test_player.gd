class_name Character
extends CharacterBody2D

@onready
var movement_animations: AnimatedSprite2D = $move_animations
@onready
var animations_player: AnimationPlayer = $animation_player
@onready
var input_state_machine: Node = $input_state_machine
@onready
var hitbox_manager: Area2D = $hitbot_manager
@onready
var j5_L_hitbox: CollisionShape2D =$hitbot_manager/j5_L_hitbox
@onready
var j5_M_hitbox: CollisionShape2D =$hitbot_manager/j5_M_hitbox
@onready
var j5_H_hitbox: CollisionShape2D =$hitbot_manager/j5_H_hitbox
@onready
var player_input_component = $player_input_component
@onready
var old_state = $input_state_machine.old_state


func _ready() -> void:
	input_state_machine.init(self, animations_player, hitbox_manager, player_input_component)

func _unhandled_input(event: InputEvent) -> void:
	input_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	input_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	j5_L_hitbox.disabled = true
	j5_M_hitbox.disabled = true
	j5_H_hitbox.disabled = true
	
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	print("movement input: " + str(player_input_component.movement_inputs()))
	print("attack input: " + str(player_input_component.attack_inputs()))
	#if is_on_floor():
		#print("chão")
	print("State: " +str($input_state_machine.old_state))
	print("State: " +str($input_state_machine.current_state))
	return 
