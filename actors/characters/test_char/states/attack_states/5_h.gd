extends State

# Movement States
@export
var idle_state: State
@export
var moving_foward_state: State
@export
var moving_back_state: State
@export
var neutral_jump_state: State
@export
var foward_jump_state: State
@export
var back_jump_state: State
@export 
var crouch_state: State

# Attack States
@export
var _5_L_State: State
@export
var _5_M_State: State
@export
var _5_H_State: State
@export
var _2_L_State: State
@export
var _2_M_State: State
@export
var _2_H_State: State

func process_input(Event: InputEvent) -> State:		
	await animations_player.animation_finished
	if parent.is_on_floor():
		if attack_input_handler() == 'L':
			return _5_L_State
		if attack_input_handler() == 'M':
			return _5_M_State
		if attack_input_handler() == 'H':
			return _5_H_State
		
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
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if attack_input_handler() == 'L':
				return _2_L_State
			if attack_input_handler() == 'M':
				return _2_M_State
			if attack_input_handler() == 'H':
				return _2_H_State
			return crouch_state
		
		if attack_input_handler() == 'N':
			return idle_state
		if input_handler() == 5:
			return idle_state
	
		
	return null
