extends P1State

#Char P1States
@export
var on_air_hit_combo_state: P1State
@export
var on_sweep_state: P1State
@export
var on_launcher_state: P1State


#Movement P1States
@export
var get_up_state : P1State
@export
var neutral_jump_state: P1State
@export
var foward_jump_state: P1State
@export
var back_jump_state: P1State

@onready
var state_machine =$".."


func enter() -> void:
	super()
	parent.velocity.y = -550

func process_physics(delta: float) -> P1State:

	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		if parent.get_hurt_type() == "high":
			return on_air_hit_combo_state
			
		if parent.get_hurt_type() == "mid":
			return on_air_hit_combo_state
			
		if parent.get_hurt_type() == "low":
			return on_air_hit_combo_state
			
		if parent.get_hurt_type() == "sweep":
			return on_sweep_state
				
		if parent.get_hurt_type() == "launcher":
			return on_air_hit_combo_state
	
	
	if parent.is_on_floor():
		return get_up_state
			
	await parent.hit_can_move
	
	if parent.is_on_floor():
		return get_up_state
		
	if !parent.is_on_floor():
		animations_player.play("air_hit_falling")
		
	 
	return null
	
	
