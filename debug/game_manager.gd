extends Node2D

@onready
var p1: P1Character = $"../p1"
@onready
var p2: P2Character = $"../p2"
@onready
var p1_hitbox_manager: hitbox_manager = $"../p1/hitbox_manager"
@onready
var p2_hitbox_manager: hitbox_manager = $"../p2/hitbox_manager"

var p1_block_stun_frames
var p1_hit_stun_frames
var p1_attack_hurt_type
var p1_attack_damage
var p1_attack_knockback

var p2_block_stun_frames
var p2_hit_stun_frames
var p2_attack_hurt_type
var p2_attack_damage
var p2_attack_knockback

func p1_is_on_right_side() -> void:
	var p1_pos = p1.position
	var p2_pos = p2.position
	
	if p1_pos > p2_pos and !p1.on_right_side:
		p1.on_right_side = true
		p1.flip_char()
		
	if p1_pos < p2_pos and p1.on_right_side:
		p1.on_right_side = false
		p1.flip_char()

func p2_is_on_right_side() -> void:
	var p1_pos = p1.position
	var p2_pos = p2.position
	
	if p2_pos > p1_pos and !p2.on_right_side:
		p2.on_right_side = true
		p2.flip_char()
		
	if p2_pos < p1_pos and p2.on_right_side:
		p2.on_right_side = false
		p2.flip_char()
		
func p1_set_hit_info(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int, hit_variant: String) -> void:

	p1_hit_stun_frames = block_stun_frames
	p1_block_stun_frames = hit_stun_frames
	p1_attack_damage = damage
	p1_attack_knockback = knockback
	p1_attack_hurt_type	 = hit_variant
	
	set_p2_hurt_vars(block_stun_frames, hit_stun_frames, hit_variant)
	
	
func p2_set_hit_info(block_stun_frames: int, hit_stun_frames:int, damage: int, knockback: int, hit_variant: String) -> void:
	
	p2_hit_stun_frames = block_stun_frames
	p2_block_stun_frames = hit_stun_frames
	p2_attack_damage = damage
	p2_attack_knockback = knockback
	p2_attack_hurt_type	 = hit_variant
	
	set_p1_hurt_vars(block_stun_frames, hit_stun_frames, hit_variant)

func set_p1_hurt_vars(block_stun_frames: int, hit_stun_frames: int, hurt_type : String) -> void:
	p1.block_stun_frames = block_stun_frames
	p1.hit_stun_frames = hit_stun_frames
	p1.hurt_type = hurt_type

		
func set_p2_hurt_vars(block_stun_frames: int, hit_stun_frames: int, hurt_type : String) -> void:
	p2.block_stun_frames = block_stun_frames
	p2.hit_stun_frames = hit_stun_frames
	p2.hurt_type = hurt_type


func _ready() -> void:
	p1_hitbox_manager.connect("hit", p1_set_hit_info)
	p2_hitbox_manager.connect("hit", p2_set_hit_info)
	
func _process(delta: float) -> void:
	print(p1.hurt_type)
	p1_is_on_right_side()
	p2_is_on_right_side()
	
