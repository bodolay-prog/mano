extends P1State

@export
var idle_state: P1State

func process_input() -> P1State: 
	parent.velocity.x = 0
	parent.move_and_slide()

	await animations_player.animation_finished
	return idle_state
	
