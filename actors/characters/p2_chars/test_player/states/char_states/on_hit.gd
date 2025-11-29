class_name on_hit_p2
extends P2State

#Char P2States
@export
var on_hit_combo_state: P2State
@export
var on_block_state: P2State
@export
var on_air_hit_state: P2State
@export
var on_sweep_state: P2State
@export
var on_launcher_state: P2State

# Movement P2States
@export
var idle_state: P2State
@export 
var crouch_state: P2State

#Input Machine Path
@onready
var state_machine_path =$".."

func enter() -> void:
	super()
	parent.hurt.emit()
	if state_machine_path.old_state == crouch_state:
		animations_player.play("crouch_hurt")
	parent.times_hited += 1
	parent.velocity.y += parent.knockback_y
		
	

func process_input() -> P2State:	
		
	if parent.get_hurt_type() == "high":
		if !parent.is_on_floor():
			return on_air_hit_state
		return on_hit_combo_state
		
	if parent.get_hurt_type() == "mid":
		if !parent.is_on_floor():
			return on_air_hit_state
		return on_hit_combo_state
			
	if parent.get_hurt_type() == "low":
		if !parent.is_on_floor():
			return on_air_hit_state
		return on_hit_combo_state

	if parent.get_hurt_type() == "sweep":
		if !parent.is_on_floor():
			return on_air_hit_state
		return on_sweep_state
			
	if parent.get_hurt_type() == "launcher":
		if !parent.is_on_floor():
			return on_air_hit_state
		return on_launcher_state
		
	if !parent.is_on_floor():
		return on_air_hit_state
		
	await parent.hit_can_move
	
	
	if parent.is_on_floor():
			
		return idle_state
		
	return null
		

func process_physics(delta: float) -> P2State:
	parent.velocity.y += gravity * delta
	if parent.hit_stun_frames > 0:
		parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	return null
