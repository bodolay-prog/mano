extends P2State

#Char P2States
@export
var on_air_hit_state: P2State
@export
var on_sweep_state: P2State
@export
var on_launcher_state: P2State


#Movement P2States
@export
var get_up_state : P2State
@export
var neutral_jump_state: P2State
@export
var foward_jump_state: P2State
@export
var back_jump_state: P2State

@onready
var state_machine =$".."

func enter() -> void:
	super()
	parent.velocity.y = -250
	parent.times_hited += 1

func process_physics(delta: float) -> P2State:
	
	parent.velocity.y += gravity * delta + (parent.times_hited * 1.25)
	if parent.hit_stun_frames > 0:
		parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "high":
		return on_air_hit_state
		
	if parent.get_hurt_type() == "mid":
		return on_air_hit_state
		
	if parent.get_hurt_type() == "low":
		return on_air_hit_state
			
	if parent.get_hurt_type() == "sweep":
		return on_sweep_state
		
	if parent.get_hurt_type() == "launcher":
			if parent.launched_times >= 2:
				return on_air_hit_state
			return on_launcher_state
		
	if parent.is_on_floor():
		return get_up_state
			
	await parent.hit_can_move
	
	if parent.is_on_floor():
		return get_up_state
		
	if !parent.is_on_floor():
		animations_player.play("air_hit_falling")
		
		
	
		
	
	return null
	
