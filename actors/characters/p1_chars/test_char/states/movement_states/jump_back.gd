extends P1State

#Char P1States
@export
var on_air_hit_state: P1State
@export
var on_air_block_state: P1State

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
var crouch_state: P1State
@export
var jump_foward_state: P1State

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
@export
var _5_jL_P1State: P1State
@export
var _5_jM_P1State: P1State
@export
var _5_jH_P1State: P1State

@export
var vertical_jump_force: float = 500
var horizontal_jump_force: float = -250
var horizontal_jump_force_right_side: float = 250

func enter() -> void:
	super()
	parent.velocity.y = -vertical_jump_force
	if parent.on_right_side:
		horizontal_jump_force = horizontal_jump_force_right_side
	else:
		horizontal_jump_force = -250

func process_physics(delta: float) -> P1State:
	parent.velocity.y += gravity * delta
	if parent.velocity.y < 0:
		parent.velocity.x = horizontal_jump_force
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		
		if parent.get_hurt_type() == "high":
			if input_handler() == 1 or input_handler() == 4:
				return on_air_block_state
			return on_air_hit_state
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_air_block_state
			return on_air_hit_state
		if parent.get_hurt_type() == "low":
			return on_air_hit_state
			
		if action_input_handler() == 'L':
			return _5_jL_P1State
		if action_input_handler() == 'M':
			return _5_jM_P1State
		if action_input_handler() == 'H':
			return _5_jH_P1State
	
	if parent.is_on_floor():
		
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
			return crouch_state
			
		if action_input_handler() == 'L':
			return _5_L_P1State
		if action_input_handler() == 'M':
			return _5_M_P1State
		if action_input_handler() == 'H':
			return _5_H_P1State
			
		if input_handler() == 9:
			return jump_foward_state
		if input_handler() == 8:
			return neutral_jump_state
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 4:
			return moving_back_state
				
			
		return idle_state
	
	return null
