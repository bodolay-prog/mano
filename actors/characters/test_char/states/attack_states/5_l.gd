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

func process_input(Event: InputEvent) -> State:	
	
	if parent.is_on_floor():
		if attack_input_handler() == 'L':
			return _5_L_State
		if attack_input_handler() == 'N':
			return idle_state
		
		if input_handler() == 7:
			print("jump trasd")
			return back_jump_state
				
		if  input_handler() == 8:
			print("jump_neutro")
			return neutral_jump_state
			
		if input_handler() == 9 :
			print("jump frente")
			return foward_jump_state
		
		if input_handler() == 6:
			print("frente")
			return moving_foward_state
		if input_handler() == 4:
			print("trasd")
			return moving_back_state
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			return crouch_state
	
		
	return null
