extends State

# Movement States
@export
var idle_state: State
@export
var moving_foward_state: State
@export
var moving_back_state: State
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
@export
var _5_jL_State: State
@export
var _5_jM_State: State
@export
var _5_jH_State: State

@export
var vertical_jump_force: float = 500

func enter() -> void:
	super()
	parent.velocity.y = -vertical_jump_force
	parent.velocity.x = 0

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		if attack_input_handler() == 'L':
			return _5_jL_State
		if attack_input_handler() == 'M':
			return _5_jM_State
		if attack_input_handler() == 'H':
			return _5_jH_State

	if parent.is_on_floor():
		if attack_input_handler() == 'L':
			return _5_L_State
		if attack_input_handler() == 'M':
			return _5_M_State
		if attack_input_handler() == 'H':
			return _5_H_State
			
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
		return idle_state
	
	return null
