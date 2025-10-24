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
	
	if parent.hit_check() == "hit":
		if input_handler() == 2:
			if action_input_handler() == 'L':
				return _2_L_P1State
			if action_input_handler() == 'M':
				return _2_M_P1State
			if action_input_handler() == 'H':
				return _2_H_P1State
		if action_input_handler() == 'L':
			return _5_L_P1State
		if action_input_handler() == 'M':
			return _5_M_P1State
		if action_input_handler() == 'H':
			return _5_H_P1State
	
	await animations_player.animation_finished
	return idle_state
	
