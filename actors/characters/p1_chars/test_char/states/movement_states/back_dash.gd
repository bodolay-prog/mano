extends P1State

@export
var post_dash_state: P1State


func process_physics(delta: float) -> P1State:
	
	parent.velocity.x = -500 * (-1 if parent.on_right_side else 1)
	
	parent.move_and_slide()
	await animations_player.animation_finished
	
	return post_dash_state
		
	return null
	
