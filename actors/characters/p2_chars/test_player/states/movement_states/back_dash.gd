class_name back_dash_p2
extends P2State

@export
var post_dash_state: P2State


func process_physics(delta: float) -> P2State:
	
	parent.velocity.x = -500 * (-1 if parent.on_right_side else 1)
	parent.move_and_slide()
	await animations_player.animation_finished
	
	return post_dash_state
		
	return null
	
