class_name _5_l_p1
extends P1State

# Movement P1States
@export
var idle_state: P1State
@export
var moving_foward_state: P1State
@export
var moving_back_state: P1State
@export
var neutral_jump_state: P1State
@export
var foward_jump_state: P1State
@export
var back_jump_state: P1State
@export 
var crouch_state: P1State

# Attack P1States
@export
var _5_L_P1State: P1State
@export
var _5_M_P1State: P1State
@export
var _5_H_P1State: P1State
@export
var _2_L_P1State: P1State
@export
var _2_M_P1State: P1State
@export
var _2_H_P1State: P1State
@export
var _3_H_P1State: P1State



func process_input() -> P1State:	

	if parent.hit_check() == "hit":
		
		if input_handler() == 1 or input_handler() == 2:
			if action_input_handler() == 'H':
				if input_handler() == 3:
					return _3_H_P1State
				return _2_H_P1State
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:	
			if action_input_handler() == 'L':
				return _2_L_P1State
			if action_input_handler() == 'M':
				return _2_M_P1State
			
		if action_input_handler() == 'L':
			return _5_L_P1State
		if action_input_handler() == 'M':
			return _5_M_P1State
		if action_input_handler() == 'H':
			return _5_H_P1State
	
	await animations_player.animation_finished
	
	return idle_state
	
	
