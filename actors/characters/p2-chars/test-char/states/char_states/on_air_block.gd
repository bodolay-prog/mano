extends State

#Movement States
@export
var idle_state: State
@export
var falling_state: State

#Char States
@export
var on_air_hit_state: State
@export
var on_air_block_combo_state: State

#Attack States
@export
var _5j_L_state: State
@export
var _5j_M_state: State
@export
var _5j_H_state: State


func process_physics(delta: float) -> State:
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
		if attack_input_handler() == 'L':
				return _5j_L_state
		if attack_input_handler() == 'M':
				return _5j_M_state
		if attack_input_handler() == 'H':
				return _5j_H_state
				
	if !parent.is_on_floor():
		return falling_state
	
	if parent.is_on_floor():
		return idle_state
		
	
	
	
	return null
	
