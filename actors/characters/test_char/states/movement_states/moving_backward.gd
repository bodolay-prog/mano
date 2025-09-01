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
	if input_handler() == 7:
		print("jump trasd")
		return back_jump_state
			
	if  input_handler() == 8:
		print("jump_neutro")
		return neutral_jump_state
		
	if input_handler() == 9 :
		print("jump frente")
		return foward_jump_state

	parent.velocity.y += gravity * delta

	var movement = -move_back_speed
	if input_handler() == 6:
		return moving_foward_state
	
	if input_handler() == 5:
		return idle_state
	
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
