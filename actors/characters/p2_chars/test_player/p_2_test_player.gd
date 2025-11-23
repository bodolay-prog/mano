class_name P2Character
extends CharacterBody2D

# Signals
signal hit_can_move()
signal block_can_move()
signal recovery_can_move()

# Child nodes or P1 nodes vars
@onready
var animations_player: AnimationPlayer = $animation_player
@onready
var state_machine: Node = $state_machine
@onready
var node_hitbox_manager: hitbox_manager = $hitbox_manager
@onready
var node_hurtbox_manager: hurtbox_manager = $hurtbox_manager
@onready
var player_input_component = $player_input_component
@onready
var old_state = $state_machine.old_state

# Char Stats
var health: int  = 10000
var sp: int = 0

# Vars that state_machine use
var motion: String
var on_right_side: bool
var launched_times: int
var times_hited: int

# Frame counter for a new hit
var hit_buffer: int = 0
var hit: String

# Vars that p1 will recieve
var hit_true: int
var block_stun_frames: int
var hit_stun_frames: int
var hurt_type : String
var knockback: int
var knockback_y: int
var recovery_frames: int

# Start Func
func _ready() -> void:
	
	state_machine.init(self, animations_player, node_hitbox_manager, node_hurtbox_manager, player_input_component)
	player_input_component.connect("motion_perfomed", process_motion)
	

# All frames-run funcs
func _process(delta: float) -> void:

	state_machine.process_input()
	frame_counter()
	
	# Degub Lines
	#print("p2 health: ", health)
	#print("p2 sp: ", sp)
	#print("p2: ", hurt_type)
	print(motion)
	#print("p2 lt: ", launched_times)
	#print(hit_buffer)
	#print(hit)
	#print(hit_stun_frames)
	#input_state_machine.process_frame(delta)
	#print("x:" +str(velocity.x) + " y: " + str(velocity.y) )
	#print("movement input: " + str(player_input_component.dir))
	#print(on_right_side)
	#print("attack input: " + str(player_input_component.attack_inputs()))
	#if is_on_floor():
		#print("chão")
	#print("State: " +str($state_machine.old_state))
	#print("State: " +str($state_machine.current_state))
	
	return 
	
func _physics_process(delta: float) -> void:
	can_move()
	state_machine.process_physics(delta)
	
	
# Data funcs
func process_motion(motion_name, button) -> void:
	
	if motion_name == "hadouken":
		if button == "L":
			motion = "L_hadouken"
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
		
func frame_counter() -> void:
	
	if hit_stun_frames > 0:
		hit_stun_frames = hit_stun_frames - 1
		await get_tree().process_frame
		
	if block_stun_frames > 0:
		block_stun_frames = block_stun_frames - 1
		await get_tree().process_frame
	
	if recovery_frames > 0:
		recovery_frames = recovery_frames - 1
		await get_tree().process_frame
	
	if hit_buffer > 0:
		hit_buffer = hit_buffer - 1
		await get_tree().process_frame
	
func get_hurt_type() -> String:
	return hurt_type

func flip_char() -> void:
		scale.x = -1


# Signals Funcs
func can_move() -> void:
	
	if hit_stun_frames == 0:
		hit_can_move.emit()
		
	if block_stun_frames == 0:
		block_can_move.emit()
	
	if recovery_frames == 0:
		recovery_can_move.emit()
		
	if hit_buffer == 0:
		hit = ""
		
func hit_check() -> String:
	return hit

func _on_hitbox_manager_hit_check() -> void:
	hit = "hit"
	sp += 50
	hit_buffer = 24
	pass # Replace with function body.

# Check Funcs

@export var push_radius: float = 14.0

func apply_push(other: Node2D, delta: float):
	var offset = other.global_position - global_position

	# distância real 2D (horizontal + vertical)
	var dist = offset.length()
	var min_dist = push_radius * 2.0

	if dist == 0 or dist >= min_dist:
		return

	# Quanto está sobrepondo
	var overlap = min_dist - dist

	# Direção normalizada 2D
	var dir = offset.normalized()

	# MAS só empurramos na horizontal (igual jogos de luta)
	var slide_x = dir.x

	# Se estiver exatamente em cima (dir.x == 0), força um pequeno empurrão
	if abs(slide_x) < 0.01:
		slide_x = 1.0 if global_position.x < other.global_position.x else -1.0

	# Aplica separação lateral suave
	global_position.x -= slide_x * (overlap * 0.5)
	other.global_position.x += slide_x * (overlap * 0.5)
