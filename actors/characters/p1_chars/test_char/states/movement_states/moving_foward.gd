extends P1State

#Char P1States
@export
var on_hit_state: P1State
@export
var on_block_state: P1State

@export
var idle_state: P1State
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
@export
var dash_back_state: P1State
@export
var dash_foward_state: P1State

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

var move_foward_speed: float = 300
var move_foward_speed_right_side: float = -300

func enter() -> void:
	super()
	if parent.on_right_side:
		move_foward_speed = move_foward_speed_right_side 
	else:
		move_foward_speed = 300
	parent.velocity.x = 0

func process_input() -> P1State:	
	
	if parent.is_on_floor():
		
		if parent.motion == "L_hadouken":
			print("l hdk")	
			
		if parent.motion == "L_shoryuken":
			print("l srk")	
			
		if parent.motion == "L_tatsumaki":
			print("l tsk")	
		
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
		
		if input_handler() == 4:
			return moving_back_state
		if input_handler() == 44:
			return dash_back_state
	
		if input_handler() == 5:
			return idle_state
			
		if input_handler() == 66:
			return dash_foward_state
		
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if action_input_handler() == 'L':
				return _2_L_P1State
			if action_input_handler() == 'M':
				return _2_M_P1State
			if action_input_handler() == 'H':
				return _2_H_P1State
			return crouch_state

	return null
	
func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta

	var movement = move_foward_speed 
	parent.velocity.x = movement
	parent.move_and_slide()
	return null
