extends State

@export
var falling_state: State
@export
var idle_state : State



func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	if parent.is_on_floor():
		return idle_state
	await animations_player.animation_finished
	
		
	if !parent.is_on_floor():
		return falling_state
	
	
	return null
	
