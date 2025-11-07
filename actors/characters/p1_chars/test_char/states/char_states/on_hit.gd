extends P1State

#Char P1States
@export
var on_hit_combo_state: P1State
@export
var on_block_state: P1State
@export
var on_sweep_state: P1State
@export
var on_launcher_state: P1State

# Movement P1States
@export
var idle_state: P1State
@export 
var crouch_state: P1State

#Input Machine Path
@onready
var state_machine_path =$".."

var knockback : float = -200
	
func enter() -> void:
	super()
	if state_machine_path.old_state == crouch_state:
		animations_player.play("low_hurt")
	parent.times_hited += 1
		
	

func process_input() -> P1State:	
		
	if parent.get_hurt_type() == "high":
		return on_hit_combo_state
		
	if parent.get_hurt_type() == "mid":
		return on_hit_combo_state
			
	if parent.get_hurt_type() == "low":
		return on_hit_combo_state

	if parent.get_hurt_type() == "sweep":
		return on_sweep_state
			
	if parent.get_hurt_type() == "launcher":
		return on_launcher_state
		
		
	await parent.hit_can_move
	
	if parent.is_on_floor():
			
		return idle_state
		
	return null
		

func process_physics(delta: float) -> P1State:
	parent.velocity.y += gravity * delta
	if parent.hit_stun_frames > 0:
		parent.velocity.x = parent.knockback * (1 if parent.on_right_side else -1)
	parent.move_and_slide()
	
	return null
