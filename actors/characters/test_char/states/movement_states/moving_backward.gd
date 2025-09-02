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
var crouch_state: State
	
func process_input(Event: InputEvent) -> State:	
	
	if input_handler() == 7:
		print("jump trasd")
		return back_jump_state
			
	if  input_handler() == 8:
		print("jump_neutro")
		return neutral_jump_state
		
	if input_handler() == 9 :
		print("jump frente")
		return foward_jump_state
		
	if input_handler() == 6:
		return moving_foward_state
	
	if input_handler() == 5:
		return idle_state
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			return crouch_state

	return null
	
func process_physics(delta: float) -> State:
	

	parent.velocity.y += gravity * delta

	var movement = -move_back_speed
	
	parent.velocity.x = movement
	parent.move_and_slide()
	return null
