extends P2State

@export
var post_dash_state: P2State


func process_physics(delta: float) -> P2State:
	parent.velocity.x = -500
	parent.move_and_slide()
	await animations_player.animation_finished
	
	return post_dash_state
		
	return null
	
