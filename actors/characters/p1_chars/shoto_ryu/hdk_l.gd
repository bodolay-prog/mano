class_name hdk_l_p1
extends P1State

# Char States
@export
var on_hit_state: P1State
		
# Movement P1States
@export
var idle_state: P1State
@export 
var crouch_state: P1State

@onready var hdk_pos = $"../../hdk_pos"
var hdk_scene : PackedScene = load(SpecialSignal.hdkp1_scene_path)
var hdk_instance: HadoukenP1

func enter() -> void:
	super()


func start_hadouken() -> void:
	if SpecialSignal.hdkp1_scene:
		var container = hdk_scene.instantiate()
		get_tree().current_scene.add_child(container)
		hdk_instance = container.get_node("hdk_body")
		
		def_hadouken()
		hdk_instance.setup()

func def_hadouken() -> void:
	
	hdk_instance.velo = 250 * (-1 if parent.on_right_side else 1)
	hdk_instance.pos = hdk_pos.global_position
	hdk_instance.block_stun_frames = 30
	hdk_instance.hit_stun_frames = 36
	hdk_instance.damage = 250
	hdk_instance.knockback = 150 
	hdk_instance.knockback_y = -200
	
	if parent.on_right_side:
		hdk_instance.direction = -1
	else:
		hdk_instance.direction =  1
		

func process_input() -> P1State:	

	if parent.get_hurt_type() == "counter":
		return on_hit_state
	
		
	await animations_player.animation_finished
	
	start_hadouken()
	
	if parent.is_on_floor():
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			return crouch_state
		return idle_state

	return	
