class_name _2_h_p2
extends P2State

# Char States
@export
var on_hit_state: P2State
	
# Movement P2States
@export
var idle_state: P2State
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

# Attack P2States
@export
var _5_L_P2State: P2State
@export
var _5_M_P2State: P2State
@export
var _5_H_P2State: P2State
@export
var _2_L_P2State: P2State
@export
var _2_M_P2State: P2State
@export
var _2_H_P2State: P2State
@export
var _3_H_P2State: P2State
@export
var tmk_l_state: P2State
@export
var tmk_m_state: P2State
@export
var tmk_ex_state: P2State
@export
var srk_l_state: P2State
@export
var srk_m_state: P2State
@export
var srk_ex_state: P2State
@export
var hdk_l_state: P2State
@export
var hdk_m_state: P2State
@export
var hdk_ex_state: P2State


func process_input() -> P2State:	

	if parent.get_hurt_type() == "counter":
		return on_hit_state
	
	if parent.hit_check() == "hit":
		
		if parent.motion == "L_tatsumaki":
			return tmk_l_state
			
		if parent.motion == "M_tatsumaki":
			return tmk_m_state
		
		if parent.motion == "H_tatsumaki":
			if parent.sp >= 250:
				return tmk_ex_state
			return tmk_m_state
			
		if parent.motion == "L_shoryuken":
			return srk_l_state
			
		if parent.motion == "M_shoryuken":
			return srk_m_state
			
		if parent.motion == "H_shoryuken":
			if parent.sp >= 250:
				return srk_ex_state
			return srk_m_state
		
		if parent.motion == "L_hadouken":
			return hdk_l_state
			
		if parent.motion == "M_hadouken":
			return hdk_m_state
			
		if parent.motion == "H_hadouken":
			if parent.sp >= 250:
				return hdk_ex_state
			return hdk_m_state
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
			
		if input_handler() == 1 or input_handler() == 2:
			if action_input_handler() == 'H':
				if input_handler() == 3:
					return _3_H_P2State
				return _2_H_P2State
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:	
			if action_input_handler() == 'L':
				return _2_L_P2State
			if action_input_handler() == 'M':
				return _2_M_P2State
			
		if action_input_handler() == 'L':
			return _5_L_P2State
		if action_input_handler() == 'M':
			return _5_M_P2State
		if action_input_handler() == 'H':
			return _5_H_P2State
	
	await animations_player.animation_finished
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
