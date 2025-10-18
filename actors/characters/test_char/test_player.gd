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

var block_stun_frames: int
var hit_stun_frames: int
var hit_variant: String

func _ready() -> void:
	input_state_machine.init(self, animations_player, node_hitbox_manager, node_hurtbox_manager, player_input_component)
	node_hitbox_manager.connect("hit",get_info)

func _unhandled_input(event: InputEvent) -> void:
	input_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	input_state_machine.process_physics(delta)
	
func get_info(block_stun_frames: int, hit_stun_frames: int, hit_variant: String) -> void:
	self.block_stun_frames = block_stun_frames
	self.hit_stun_frames = hit_stun_frames
	self.hit_variant = hit_variant

func get_block_stun_frames() -> int:
	return block_stun_frames
	
func get_hit_stun_frames() -> int:
	return hit_stun_frames
	
func get_hit_variant() -> String:
	return hit_variant

func _process(delta: float) -> void:
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	#print("movement input: " + str(player_input_component.movement_inputs()))
	#print("attack input: " + str(player_input_component.attack_inputs()))
	#if is_on_floor():
		#print("chão")
	#print("State: " +str($input_state_machine.old_state))
	#print("State: " +str($input_state_machine.current_state))
	return 
