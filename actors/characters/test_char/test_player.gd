class_name Character
extends CharacterBody2D

@onready
var animations_player: AnimationPlayer = $animation_player
@onready
var input_state_machine: Node = $input_state_machine
@onready
var node_hitbox_manager: hitbox_manager = $hitbox_manager
@onready
var node_hurtbox_manager: hurtbox_manager = $hurtbox_manager
@onready
var j5_L_hitbox = $hitbox_manager/high_hit_manager/j5_L_area/j5_L_hitbox
@onready
var j5_M_hitbox = $hitbox_manager/high_hit_manager/j5_M_area/j5_M_hitbox
@onready
var j5_H_hitbox = $hitbox_manager/high_hit_manager/j5_H_area/j5_H_hitbox
@onready
var player_input_component = $player_input_component
@onready
var old_state = $input_state_machine.old_state


func _ready() -> void:
	input_state_machine.init(self, animations_player, node_hitbox_manager, node_hurtbox_manager, player_input_component)

func _unhandled_input(event: InputEvent) -> void:
	input_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	input_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	if is_on_floor():
		j5_L_hitbox.disabled = true
		j5_M_hitbox.disabled = true
		j5_H_hitbox.disabled = true
	
	#print(str($dash_timer.time_left))j
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	#print("movement input: " + str(player_input_component.movement_inputs()))
	#print("attack input: " + str(player_input_component.attack_inputs()))
	#if is_on_floor():
		#print("chão")
	#print("State: " +str($input_state_machine.old_state))
	#print("State: " +str($input_state_machine.current_state))
	return 
