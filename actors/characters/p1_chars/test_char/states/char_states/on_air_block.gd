extends P1State

#Movement P1States
@export
var idle_state: P1State
@export
var falling_state: P1State

#Char P1States
@export
var on_air_hit_state: P1State
@export
var on_air_block_combo_state: P1State

#Attack P1States
@export
var _5j_L_state: P1State
@export
var _5j_M_state: P1State
@export
var _5j_H_state: P1State


func process_physics(delta: float) -> P1State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if parent.get_hurt_state() == "high":
		if input_handler() == 1 or input_handler() == 4:
			return on_air_block_combo_state
		return on_air_hit_state
	if parent.get_hurt_state() == "mid":
		if input_handler() == 1 or input_handler() == 4:
			return on_air_block_combo_state
		return on_air_hit_state
	if parent.get_hurt_state() == "low":
		return on_air_hit_state
			
	await animations_player.animation_finished
	
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
	
