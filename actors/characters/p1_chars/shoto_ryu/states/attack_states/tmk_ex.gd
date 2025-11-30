class_name tmk_ex_p1
extends P1State

# Char States
@export
var on_hit_state: P1State
		
# Movement P1States
@export
var idle_state: P1State
@export 
var crouch_state: P1State

@onready
var special: special_hit = $"../../hitbox_manager/special_hit_manager"

func enter() -> void:
	super()
	animations_player.set_deferred("Speed Scale", 0.55)
	parent.sp += - 500
	parent.velocity.x = 0
	parent.position.y += -3
	parent.velocity.y += -30
	parent.motion = " "
	special.hit_stun_frames = 50
	special.block_stun_frames = 10
	special.knockback = -30
	special.knockback_y = -83
	special.ender_hit_stun_frames = 40
	special.ender_block_stun_frames = 18
	special.ender_knockback = 100
	special.ender_knockback_y = -430

func process_input() -> P1State:	

	parent.move_and_slide()
	
	if parent.get_hurt_type() == "counter":
		return on_hit_state
		
	await animations_player.animation_finished
	
	
	if input_handler() == 1 or input_handler() == 2 or input_handler() == 3:
		return crouch_state
	return idle_state
	
	
