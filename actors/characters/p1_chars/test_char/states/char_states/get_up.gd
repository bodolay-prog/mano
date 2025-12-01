class_name get_up_p1
extends P1State

@export
var idle_state: P1State

func enter() -> void:
	super()
	parent.times_hited = 0
	parent.launched_times = 0

func process_input() -> P1State: 
	
	parent.velocity.x = 0
	parent.velocity.y = 0
	parent.move_and_slide()
	
	await animations_player.animation_finished
	return idle_state
	
