class_name idle_p1
extends P1State

#Char P1States
@export
var on_hit_state: P1State
@export
var on_block_state: P1State
@export
var on_sweep_state: P1State
@export
var on_launcher_state: P1State

# Movement P1States
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
@export
var _3_H_P1State: P1State
@export
var tmk_l_state: P1State
@export
var tmk_m_state: P1State
@export
var tmk_ex_state: P1State
@export
var srk_l_state: P1State
@export
var srk_m_state: P1State
@export
var srk_ex_state: P1State
@export
var hdk_l_state: P1State
@export
var hdk_m_state: P1State
@export
var hdk_ex_state: P1State
	
func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.times_hited = 0
	parent.launched_times = 0

func process_input() -> P1State:	
	
	if parent.is_on_floor():
		
		if parent.motion == "L_tatsumaki":
			return tmk_l_state
			
		if parent.motion == "M_tatsumaki":
			return tmk_m_state
		
		if parent.motion == "H_tatsumaki":
			if parent.sp >= 500:
				return tmk_ex_state
			return tmk_m_state
			
		if parent.motion == "L_shoryuken":
			return srk_l_state
			
		if parent.motion == "M_shoryuken":
			return srk_m_state
			
		if parent.motion == "H_shoryuken":
			if parent.sp >= 500:
				return srk_ex_state
			return srk_m_state
			
		if parent.motion == "L_hadouken":
			return hdk_l_state
			
		if parent.motion == "M_hadouken":
			return hdk_m_state
			
		if parent.motion == "H_hadouken":
			if parent.sp >= 500:
				return hdk_ex_state
			return hdk_m_state
		
		if parent.get_hurt_type() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_type() == "low":
			if input_handler() == 1:
				return on_block_state
			return on_hit_state

		if parent.get_hurt_type() == "sweep":
			if input_handler() == 1:
				return on_block_state
			return on_sweep_state
			
		if parent.get_hurt_type() == "launcher":
			if input_handler() == 1:
				return on_block_state
			return on_launcher_state
			
		if parent.get_hurt_type() == "high":
			if input_handler() == 4:
				return on_block_state
			if input_handler() == 1:
				return on_hit_state
			return on_hit_state
			
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
	
		if  action_input_handler() == "dash":
			return dash_foward_state
			
		if input_handler() == 6:
			if action_input_handler() == "dash":
				return dash_foward_state
			return moving_foward_state
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
			
		if input_handler() == 4:
			if action_input_handler() == "dash":
				return dash_back_state
			return moving_back_state
			
		if input_handler() == 44:
			return dash_back_state
		
	return null
		

func process_physics(delta: float) -> P1State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	return null
