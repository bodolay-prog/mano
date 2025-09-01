extends State

@export
var idle_state: State
@export
var moving_back_state: State
@export
var moving_foward_state: State
@export 
var crouch_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	if parent.is_on_floor():
		if input_handler() == 4:
			return moving_foward_state
		if input_handler() == 6:
			return moving_back_state
		return idle_state
		
	return null
