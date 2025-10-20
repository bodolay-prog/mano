extends State

@export
var _5j_L_state: State
@export
var _5j_M_state: State
@export
var _5j_H_state: State


# Movement States
@export
var idle_state : State
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
@export
var dash_foward_state: State
@export
var dash_back_state: State
@export
var falling_state: State



func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.is_on_floor():
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
		
	if parent.get_hit_variant() == "high_hit":
		if attack_input_handler() == 'L':
				return _5j_L_state
		if attack_input_handler() == 'M':
				return _5j_M_state
		if attack_input_handler() == 'H':
				return _5j_H_state
				
	await animations_player.animation_finished
	
	if !parent.is_on_floor():
		return falling_state
		
	
	
	
	return null
	
