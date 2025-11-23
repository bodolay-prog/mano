class_name tmk_l
extends P2State

# Char States
@export
var on_hit_state: P2State
		
# Movement P2States
@export
var idle_state: P2State
@export 
var crouch_state: P2State

func enter() -> void:
	super()
	parent.motion = " "

func process_input() -> P2State:	

	parent.velocity.x = 250 * (-1 if parent.on_right_side else 1)
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "counter":
		return on_hit_state
		
	await animations_player.animation_finished
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
