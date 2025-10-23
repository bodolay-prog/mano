class_name P1Character
extends CharacterBody2D

signal can_move()

@onready
var hitbox_p2 : hitbox_manager = $"../p2/hitbox_manager"
@onready
var hurtbox_p2 : hurtbox_manager = $"../p2/hurtbox_manager"
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
var motion: String
var on_right_side: bool

# All frames-run funcs
func _ready() -> void:
	
	input_state_machine.init(self, animations_player, node_hitbox_manager, node_hurtbox_manager, player_input_component)
	hitbox_p2.connect("hit", set_hit_info)
	player_input_component.connect("motion_perfomed", process_motion)
	

func _process(delta: float) -> void:
	frame_counter()
	#print(hit_stun_frames)
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
	p_can_move()
	input_state_machine.process_physics(delta)
	
# Data funcs
func set_hit_info(block_stun_frames: int, hit_stun_frames: int, hit_variant: String) -> void:
	self.block_stun_frames = block_stun_frames
	self.hit_stun_frames = hit_stun_frames
	hurt_state = hit_variant
	
func process_motion(motion_name, button) -> void:
	
	if motion_name == "hadouken":
		if button == "L":
			motion = ""
		if button == "M":
			motion = "M_hadouken"
		if button == "H":
			motion = "H_hadouken"
		if button == "S":
			motion = "S_hadouken"
			
	if motion_name == "tatsumaki":
		if button == "L":
			motion = "L_tatsumaki"
		if button == "M":
			motion = "M_tatsumaki"
		if button == "H":
			motion = "H_tatsumaki"
		if button == "S":
			motion = "S_tatsumaki"
			
	if motion_name  == "shoryuken":
		if button == "L":
			motion = "L_shoryuken"
		if button == "M":
			motion = "M_shoryuken"
		if button == "H":
			motion = "H_shoryuken"
		if button == "S":
			motion = "S_shoryuken"
		
	if motion_name  == "quarter_circle_back":
		if button == "L":
			motion = "L_quarter_circle_back"
		if button == "M":
			motion = "M_quarter_circle_back"
		if button == "H":
			motion = "H_quarter_circle_back"
		if button == "S":
			motion = "S_quarter_circle_back"
		
	
func p_can_move() -> void:
	if hit_stun_frames == 0 and block_stun_frames == 0:
		can_move.emit()
		
func frame_counter() -> void:
	if hit_stun_frames > 0:
		hit_stun_frames = hit_stun_frames - 1
		await get_tree().process_frame
		
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
	
