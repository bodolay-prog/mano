extends P1State

#Char P1States
@export
var on_hit_state: P1State
@export
var on_block_state: P1State

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
var foward_jump_state: P1State
@export
var back_jump_state: P1State
@export 
var crouch_state: P1State
@export
var dash_foward_state: P1State
@export
var dash_back_state: P1State

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
	
#Input Machine Path
@onready
var state_machine_path =$".."
	
func enter() -> void:
	super()
	if state_machine_path.old_state == crouch_state:
		animations_player.play("low_block")
	

func process_input() -> P1State:	
	
	await parent.block_can_move
	
	if parent.is_on_floor():
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
	if parent.is_on_floor():
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_type() == "low":
			if input_handler() == 1:
				return on_block_state
			return on_hit_state
	
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 4:
			return moving_back_state
			
		if input_handler() == 7:
			return back_jump_state
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
			
		if input_handler() == 66:
			return dash_foward_state
			
		if input_handler() == 44:
			return dash_back_state
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			if action_input_handler() == 'L':
				return _2_L_P1State
			if action_input_handler() == 'M':
				return _2_M_P1State
			if action_input_handler() == 'H':
				return _2_H_P1State
			return crouch_state
			
		if action_input_handler() == 'L':
			return _5_L_P1State
		if action_input_handler() == 'M':
			return _5_M_P1State
		if action_input_handler() == 'H':
			return _5_H_P1State
		return idle_state
	return null
		

func process_physics(delta: float) -> P1State:
	parent.velocity.y += gravity * delta
	parent.velocity.x = parent.knockback * (-1 if parent.on_right_side else 1)
	parent.move_and_slide()
	
	return null
