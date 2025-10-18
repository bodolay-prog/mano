extends State

#Char States
@export
var on_hit_state: State
@export
var on_block_state: State

@export
var idle_state: State
@export
var moving_foward_state: State
@export
var neutral_jump_state: State
@export
var foward_jump_state: State
@export
var back_jump_state: State
@export 
var crouch_state: State
@export
var dash_back_state: State
@export
var dash_foward_state: State

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

var move_back_speed: float = 230
	
func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input() -> State:	
		
	if parent.is_on_floor():

		if parent.get_hurt_state() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_state() == "low":
			if input_handler() == 1:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_state() == "high":
			if input_handler() == 4:
				return on_block_state
			if input_handler() == 1:
				return on_hit_state
			return on_hit_state
			
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
			
		if input_handler() == 44:
			return dash_back_state
			
		if input_handler() == 66:
			return dash_foward_state
		
		if input_handler() == 5:
			return idle_state
		
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if attack_input_handler() == 'L':
				return _2_L_State
			if attack_input_handler() == 'M':
				return _2_M_State
			if attack_input_handler() == 'H':
				return _2_H_State
			return crouch_state

	return null
	
func process_physics(delta: float) -> State:
	

	parent.velocity.y += gravity * delta

	var movement = -move_back_speed
	
	parent.velocity.x = movement
	parent.move_and_slide()
	return null
