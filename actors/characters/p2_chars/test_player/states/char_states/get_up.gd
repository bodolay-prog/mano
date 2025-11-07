extends P2State

@export
var idle_state: P2State

func process_input() -> P2State: 
	parent.velocity.x = 0
	parent.velocity.y = 0
	parent.move_and_slide()
	parent.times_hited = 0
	parent.launched_times = 0
	await animations_player.animation_finished
	return idle_state
	
