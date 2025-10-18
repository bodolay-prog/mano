extends State

#Char States
@export
var on_hit_state: State
@export
var on_block_state: State

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
var idle_state: State
@export
var crouch_state: State

#attack states
@export
var _2_L_State: State
@export
var _2_M_State: State
@export
var _2_H_State: State

#Input Machine Path
@onready
var state_machine_path =$".."

func enter() -> void:
	
	if state_machine_path.old_state == _2_L_State or state_machine_path.old_state == _2_M_State or state_machine_path.old_state == _2_H_State or state_machine_path.old_state == crouch_state:
		animations_player.play("crouched") 
	else:
		animations_player.play("crouch")
		
	parent.velocity.x = 0

func process_input() -> State:	

	if parent.is_on_floor():
	
		if parent.get_hurt_state() == "mid":
			if input_handler() == 1 or input_handler() == 4:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_state() == "low":
			if input_handler() == 1:
				return on_block_state
			return on_hit_state
			
		if parent.get_hurt_state() == "high":
			if input_handler() == 4:
				return on_block_state
			if input_handler() == 1:
				return on_hit_state
			return on_hit_state
			
		if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
			# 2 attack inputs
			if attack_input_handler() == 'L':
				return _2_L_State
			if attack_input_handler() == 'M':
				return _2_M_State
			if attack_input_handler() == 'H':
				return _2_H_State
		
		
		if input_handler() == 7:
			return back_jump_state
				
		if  input_handler() == 8:
			return neutral_jump_state
			
		if input_handler() == 9 :
			return foward_jump_state
		
		if input_handler() == 6:
			return moving_foward_state
		if input_handler() == 4:
			return moving_back_state
		if input_handler() == 5:
			return idle_state
	return null
		

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	return null
