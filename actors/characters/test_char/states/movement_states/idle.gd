extends State

@export
var moving_foward_state: State
@export
var moving_back_state: State
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

func enter() -> void:
	super()
	parent.velocity.x = 0

func process_input(Event: InputEvent) -> State:
	if get_jump() and parent.is_on_floor() and get_movement_input() > 0:
		print("jump_frente")
		return foward_jump_state
	if  get_movement_input() < 0 and get_jump() and parent.is_on_floor() :
		print("jump_tras")
		return back_jump_state
	if get_jump() and parent.is_on_floor():
		print("jump_neutro")
		return neutral_jump_state
	if get_movement_input() > 0 and parent.is_on_floor():
		print("frente")
		return moving_foward_state
	if get_movement_input() < 0 and parent.is_on_floor():
		print("trasd")
		return moving_back_state
	return null
		

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
