class_name Hadouken
extends CharacterBody2D

@onready var animation_player = $"../animations"

var velo = 250
var pos = Vector2(0, 0)
var direction = 1
var hit_stun_frames
var block_stun_frames
var damage
var knockback
var knockback_y

func _ready() -> void:
	global_position = pos

func _process(delta: float) -> void:
	
	animation_player.play("hadouken")
	velocity.x  = 250 * 1
	move_and_slide()
	

func _on_hitbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("p2_hurtbox"):
		SpecialSignal.hadouken_hit_signal_p1.emit(block_stun_frames, hit_stun_frames, damage, knockback, knockback_y)
		animation_player.play("hit")
	pass # Replace with function body.
