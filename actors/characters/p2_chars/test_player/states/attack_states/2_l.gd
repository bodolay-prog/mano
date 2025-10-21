extends P2State

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

func process_input() -> P2State:	
	
	if parent.get_hit_variant() == "low_hit":
		if input_handler() == 2:
			if attack_input_handler() == 'L':
				return _2_L_P1State
			if attack_input_handler() == 'M':
				return _2_M_P1State
			if attack_input_handler() == 'H':
				return _2_H_P1State
		if attack_input_handler() == 'L':
			return _5_L_P1State
		if attack_input_handler() == 'M':
			return _5_M_P1State
		if attack_input_handler() == 'H':
			return _5_H_P1State
	
	await animations_player.animation_finished
	if parent.is_on_floor():
		
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if attack_input_handler() == 'L':
				return _2_L_P1State
			if attack_input_handler() == 'M':
				return _2_M_P1State
			if attack_input_handler() == 'H':
				return _2_H_P1State
			return crouch_state
			
		if attack_input_handler() == 'L':
			return _5_L_P1State
		if attack_input_handler() == 'M':
			return _5_M_P1State
		if attack_input_handler() == 'H':
			return _5_H_P1State
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
		
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 4:
			return moving_back_state
		
		if attack_input_handler() == 'N':
			return idle_state
		if input_handler() == 5:
			return idle_state
	
		
	return null
