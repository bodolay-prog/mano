extends P2State

#Char P1States
@export
var on_air_hit_state: P2State
@export
var on_air_block_state: P2State

# Movement P1States
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

# Attack P1States
@export
var _5_L_P1State: P2State
@export
var _5_M_P1State: P2State
@export
var _5_H_P1State: P2State
@export
var _2_L_P1State: P2State
@export
var _2_M_P1State: P2State
@export
var _2_H_P1State: P2State
@export
var _5_jL_P1State: P2State
@export
var _5_jM_P1State: P2State
@export
var _5_jH_P1State: P2State

func process_physics(delta: float) -> P2State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		if parent.get_hurt_type() == "high":
			if input_handler() == 1 or input_handler() == 4:
				return on_air_block_state
			return on_air_hit_state
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_air_block_state
			return on_air_hit_state
		if parent.get_hurt_type() == "low":
			return on_air_hit_state
		
		if action_input_handler() == 'L':
			return _5_jL_P1State
		if action_input_handler() == 'M':
			return _5_jM_P1State
		if action_input_handler() == 'H':
			return _5_jH_P1State

	
	if parent.is_on_floor():
		if action_input_handler() == 'L':
			return _5_L_P1State
		if action_input_handler() == 'M':
			return _5_M_P1State
		if action_input_handler() == 'H':
			return _5_H_P1State
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
		
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 5:
			return idle_state
		if input_handler() == 4:
			return moving_back_state
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if action_input_handler() == 'L':
				return _2_L_P1State
			if action_input_handler() == 'M':
				return _2_M_P1State
			if action_input_handler() == 'H':
				return _2_H_P1State
			return crouch_state
	return null
	

	
