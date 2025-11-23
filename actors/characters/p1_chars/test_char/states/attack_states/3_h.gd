class_name _3_h_p1
extends P1State

# Char States
@export
var on_hit_state: P1State

# Movement P1States
@export
var idle_state: P1State
@export 
var crouch_state: P1State

func process_input() -> P1State:	

	if parent.get_hurt_type() == "counter":
		return on_hit_state

	await animations_player.animation_finished
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
