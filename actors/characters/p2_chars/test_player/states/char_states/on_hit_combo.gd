extends P2State

#Char P2States
@export
var on_hit_state: P2State
@export
var on_block_state: P2State
@export
var on_sweep_state: P2State
@export
var on_launcher_state: P2State

# Movement P2States
@export
var idle_state: P2State
@export
var moving_foward_state: P2State
@export
var moving_back_state: P2State
@export
var neutral_jump_state: P2State
@export
var foward_jump_state: P2State
@export
var back_jump_state: P2State
@export
var crouch_state: P2State
@export
var dash_foward_state: P2State
@export
var dash_back_state: P2State

# Attack P2States
@export
var _5_L_P2State: P2State
@export
var _5_M_P2State: P2State
@export
var _5_H_P2State: P2State
@export
var _2_L_P2State: P2State
@export
var _2_M_P2State: P2State
@export
var _2_H_P2State: P2State
@export
var _3_H_P2State: P2State
	
#Input Machine Path
@onready
var state_machine_path =$".."
	
func enter() -> void:
	super()
	if state_machine_path.old_state == crouch_state:
		animations_player.play("low_hurt")
	

func process_input() -> P2State:
	
	if parent.get_hurt_type() == "high":
		return on_hit_state
	
	if parent.get_hurt_type() == "mid":
		return on_hit_state
			
	if parent.get_hurt_type() == "low":
		return on_hit_state

	if parent.get_hurt_type() == "sweep":
			return on_sweep_state
			
	if parent.get_hurt_type() == "launcher":
		return on_launcher_state
	
	await parent.hit_can_move
	
	if parent.is_on_floor():

		if parent.get_hurt_type() == "high":
			if input_handler() == 4:
				return on_block_state
			return on_hit_state
		
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_type() == "low":
			if input_handler() == 1:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_type() == "sweep":
			if input_handler() == 1:
				return on_block_state
			return on_sweep_state
			
		if parent.get_hurt_type() == "launcher":
			if input_handler() == 1:
				return on_block_state
			return on_launcher_state
		
		if input_handler() == 1 or input_handler() == 2:
			if action_input_handler() == 'H':
				if input_handler() == 3:
					return _3_H_P2State
				return _2_H_P2State
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:	
			if action_input_handler() == 'L':
				return _2_L_P2State
			if action_input_handler() == 'M':
				return _2_M_P2State
			return crouch_state
			
		if action_input_handler() == 'L':
			return _5_L_P2State
		if action_input_handler() == 'M':
			return _5_M_P2State
		if action_input_handler() == 'H':
			return _5_H_P2State
		
		if input_handler() == 6:
			return moving_foward_state
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
			
		if input_handler() == 66:
			return dash_foward_state
			
		if input_handler() == 4:
			return moving_back_state
		if input_handler() == 44:
			return dash_back_state
			
		return idle_state
		
	return null
		

func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta
	if parent.hit_stun_frames > 0:
		parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	return null
