class_name on_air_hit_p1
extends P1State

#Char P1States
@export
var on_air_combo_hit_state: P1State
@export
var on_hit_state: P1State
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
	parent.hurt.emit()
	if state_machine.old_state != on_hit_state:
		parent.velocity.y = -250
	if state_machine.old_state != on_hit_state:
		parent.velocity.y += parent.knockback_y
	parent.times_hited += 1

func process_physics(delta: float) -> P1State:
	
	parent.velocity.y += gravity * delta + (parent.times_hited * 1.25)
	parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1) * 0.55
	parent.move_and_slide()
	
	if parent.get_hurt_type() == "high":
		return on_air_combo_hit_state
		
	if parent.get_hurt_type() == "mid":
		return on_air_combo_hit_state
		
	if parent.get_hurt_type() == "low":
		return on_air_combo_hit_state
			
	if parent.get_hurt_type() == "sweep":
		return on_sweep_state
		
	if parent.get_hurt_type() == "launcher":
			if parent.launched_times >= 3:
				return on_air_combo_hit_state
			return on_launcher_state
		
	if parent.is_on_floor():
		return get_up_state
			
	await parent.hit_can_move
	
	if parent.is_on_floor():
		return get_up_state
		
	if !parent.is_on_floor():
		animations_player.play("air_hit_falling")
		
		
	
		
	
	return null
	
