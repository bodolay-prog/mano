extends P2State

# Movement P2States
@export
var idle_state: P2State
@export 
var crouch_state: P2State

func process_input() -> P2State:	
	
	await animations_player.animation_finished
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
