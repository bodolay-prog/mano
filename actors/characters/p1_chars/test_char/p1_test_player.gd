class_name P1Character
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
var player_input_component = $player_input_component
@onready
var old_state = $input_state_machine.old_state

var block_stun_frames: int
var hit_stun_frames: int
var hit_variant: String
var hurt_state: String
var on_right_side: bool

# All frames-run funcs
func _ready() -> void:
	input_state_machine.init(self, animations_player, node_hitbox_manager, node_hurtbox_manager, player_input_component)
	node_hitbox_manager.connect("hit",get_hit_info)

func _process(delta: float) -> void:
	input_state_machine.process_input()
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	#print("movement input: " + str(player_input_component.dir))
	#print(on_right_side)
	#print("attack input: " + str(player_input_component.attack_inputs()))
	#if is_on_floor():
		#print("chão")
	#print("State: " +str($input_state_machine.old_state))
	#print("State: " +str($input_state_machine.current_state))
	return 
	
func _physics_process(delta: float) -> void:
	input_state_machine.process_physics(delta)
	

	
# Data funcs
func get_hit_info(block_stun_frames: int, hit_stun_frames: int, hit_variant: String) -> void:
	self.block_stun_frames = block_stun_frames
	self.hit_stun_frames = hit_stun_frames
	self.hit_variant = hit_variant
	
func get_hurt_info(char_state: String) -> void:
	self.hurt_state = char_state
	
func get_hurt_state() -> String:
	return hurt_state

func get_block_stun_frames() -> int:
	return block_stun_frames
	
func get_hit_stun_frames() -> int:
	return hit_stun_frames
	
func get_hit_variant() -> String:
	return hit_variant

func flip_char() -> void:
		scale.x = -1


# Signals
func _on_hitbox_manager_debuig_hit_test(hit_variant: String) -> void:
	get_hurt_info(hit_variant)
	pass # Replace with function body.

func _on_debug_hit_reset() -> void:
	get_hurt_info("")
	pass # Replace with function body.
	
