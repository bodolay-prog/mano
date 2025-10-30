extends P2State

#Movement P1States
@export
var idle_state: P2State
@export
var falling_state: P2State

#Char P1States
@export
var on_air_hit_state: P2State
@export
var on_air_block_combo_state: P2State

#Attack P1States
@export
var _5j_L_state: P2State
@export
var _5j_M_state: P2State
@export
var _5j_H_state: P2State


func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "high":
		if input_handler() == 1 or input_handler() == 4:
			return on_air_block_combo_state
		return on_air_hit_state
		
	if parent.get_hurt_type() == "mid":
		if input_handler() == 1 or input_handler() == 4:
			return on_air_block_combo_state
		return on_air_hit_state
		
	if parent.get_hurt_type() == "low":
		return on_air_hit_state
		
	await parent.block_can_move
	
	if parent.get_hit_variant() == "high_hit":
		if action_input_handler() == 'L':
				return _5j_L_state
		if action_input_handler() == 'M':
				return _5j_M_state
		if action_input_handler() == 'H':
				return _5j_H_state
				
	if !parent.is_on_floor():
		return falling_state
	
	if parent.is_on_floor():
		return idle_state
		
	
	
	
	return null
	
