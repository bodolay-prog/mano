class_name HadoukenP2
extends CharacterBody2D

@onready var animation_player = $"../animations"

var velo 
var pos 
var direction = -1
var hit_stun_frames
var block_stun_frames
var damage
var knockback
var knockback_y
var hit_t = 0

func setup() -> void:
	animation_player.play("hadouken")
	if direction == 1:
		scale.x = 1
	if direction == -1:
		scale.x = -1
	velocity.x  = velo * direction
	global_position = pos

func _physics_process(delta: float) -> void:
	move_and_slide()
	

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p1_hurtbox"):
		animation_player.play("hit")
		velocity.x = 0
		CharsGlobals.p2hitboxall.hit_signal_emit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y, "mid")
	pass # Replace with function body.
