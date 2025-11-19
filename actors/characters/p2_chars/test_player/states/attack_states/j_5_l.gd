class_name _j5_l_p2
extends P2State

@export
var _5j_L_state: P2State
@export
var _5j_M_state: P2State
@export
var _5j_H_state: P2State


# Movement P1States
@export
var idle_state : P2State
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
@export
var falling_state: P2State



func process_physics(delta: float) -> P2State:
	
	
	if parent.hit_check() == "hit":
		
		
		if action_input_handler() == 'L':
				return _5j_L_state
		if action_input_handler() == 'M':
				return _5j_M_state
		if action_input_handler() == 'H':
				return _5j_H_state
	
	if parent.is_on_floor():
		if input_handler() == 6:
			return moving_foward_state
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
			
		if action_input_handler() == "dash":
			return dash_foward_state
			
		if input_handler() == 4:
			if action_input_handler() == "dash":
				return dash_back_state
			return moving_back_state
			
		return idle_state
			
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	await animations_player.animation_finished
	
	if !parent.is_on_floor():
		return falling_state
		
	
	
	
	return null
	
