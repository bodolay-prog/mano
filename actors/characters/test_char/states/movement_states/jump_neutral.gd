extends State

@export
var idle_state: State
@export
var moving_back_state: State
@export
var moving_foward_state: State
@export 
var crouch_state: State

@export
var vertical_jump_force: float = 500

func enter() -> void:
	super()
	parent.velocity.y = -vertical_jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	if parent.is_on_floor():
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 4:
			return moving_back_state
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			return crouch_state
		return idle_state
	
	return null
