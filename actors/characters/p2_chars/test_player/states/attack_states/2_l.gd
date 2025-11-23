class_name _2_l_p2
extends P2State

# Char States
@export
var on_hit_state: P2State

		
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

func process_input() -> P2State:	

	if parent.get_hurt_type() == "counter":
		return on_hit_state
		
	if parent.hit_check() == "hit":
		
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
			
		if action_input_handler() == 'L':
			return _5_L_P2State
		if action_input_handler() == 'M':
			return _5_M_P2State
		if action_input_handler() == 'H':
			return _5_H_P2State
	
	await animations_player.animation_finished
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
