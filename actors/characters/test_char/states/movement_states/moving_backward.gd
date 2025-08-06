extends State

@export
var idle_state: State
@export
var moving_foward_state: State
@export
var neutral_jump_state: State
@export
var foward_jump_state: State
@export
var back_jump_state: State
@export
var fall_state: State
@export 
var crouch_state: State
	
func process_physics(delta: float) -> State:
	if get_jump() and parent.is_on_floor():
		print("jump_neutro")
		return neutral_jump_state
	if get_jump() and parent.is_on_floor() and get_movement_input() > 0:
		print("jump_frente")
		return foward_jump_state
	if get_jump() and parent.is_on_floor() and get_movement_input() < 0:
		print("jump_tras")
		return back_jump_state

	parent.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	if get_movement_input() > 0:
		return moving_foward_state
	
	if movement == 0:
		return idle_state
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
