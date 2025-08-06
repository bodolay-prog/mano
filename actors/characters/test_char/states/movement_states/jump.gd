extends State

@export
var idle_state: State
@export
var moving_back_state: State
@export
var moving_foward_state: State
@export
var fall_state: State
@export 
var crouch_state: State

@export
var jump_force: float = 900

func enter() -> void:
	super()
	parent.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = get_movement_input() * move_speed
	
	if parent.is_on_floor():
		if movement > 0:
			return moving_foward_state
		if movement < 0:
			return moving_back_state
		return idle_state
	
	return null
