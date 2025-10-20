extends State

@export
var idle_state: State

func process_input() -> State: 
	parent.velocity.x = 0
	parent.move_and_slide()
	await animations_player.animation_finished
	return idle_state
	return null
	
