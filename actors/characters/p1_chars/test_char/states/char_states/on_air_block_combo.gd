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
var on_air_block_state: P1State
@export
var on_sweep_state: P1State
@export
var on_launcher_state: P1State

#Attack P1States
@export
var _5j_L_state: P1State
@export
var _5j_M_state: P1State
@export
var _5j_H_state: P1State

func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta
	if parent.block_stun_frames > 0:
		parent.velocity.x = (parent.knockback * (1 if parent.on_right_side else -1)) * 0.5
	parent.move_and_slide()
	
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

	if parent.get_hurt_type() == "sweep":
		if input_handler() == 1:
			return on_air_block_state
		return on_sweep_state
		
	if parent.get_hurt_type() == "launcher":
		if input_handler() == 1:
			return on_air_block_state
		return on_launcher_state
		
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
	
